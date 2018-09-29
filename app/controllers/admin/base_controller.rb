class Admin::BaseController < ApplicationController
  before_action :ensure_admin!

  private

  def ensure_admin!
    authenticate_or_request_with_http_basic do |l, p|
      session[:admin] = true
      l == login && p == password
    end
  end

  def login
    "admin"
  end

  def password
    ENV.fetch("ADMIN_PASSWORD")
  end
end
