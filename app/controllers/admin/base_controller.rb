class Admin::BaseController < ApplicationController
  include SessionsHelper
  layout 'admin'
  before_filter :signed_in_user
  before_filter :require_admin_user
end
