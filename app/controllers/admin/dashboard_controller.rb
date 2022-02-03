class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_USER_NAME"], password: ENV["ADMIN_PASSWORD"]

  def show
  @count_product=Product.count
  @count_category=Category.count
  end
end
