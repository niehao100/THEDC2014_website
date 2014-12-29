# -*- coding: utf-8 -*-
include ApplicationHelper
include SessionsHelper

RSpec::Matchers.define :have_error_msg do |msg|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: msg)
  end
end

RSpec::Matchers.define :have_success_msg do |msg|
  match do |page|
    expect(page).to have_selector('div.alert.alert-success', text: msg)
  end
end

def valid_signin(user)
  fill_in "邮箱", with: user.email
  fill_in "密码", with: user.password
  click_button "登入"
end

def rspec_sign_in(user, options={})
  if options[:no_capybara]
    remember_token = new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, encrypt_token(remember_token))
  else
    visit signin_path
    valid_signin(user)
  end
end
