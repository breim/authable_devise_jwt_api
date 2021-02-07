class PagesController < ApplicationController
  before_action :set_employee

  def index
    render json: { employee: @employee }
  end

  private

  def set_employee
    return head 401 if request.headers['Authorization'].nil?

    begin
      token = JWT.decode(request.headers['Authorization'].split('Bearer ').dig(1), ENV['DEVISE_JWT_SECRET_KEY']).dig(0, 'jti')
    rescue StandardError
      return head 401
    end

    puts token

    @employee = Employee.find_by_jti(token)

    return head 401 if @employee.nil?
  end
end