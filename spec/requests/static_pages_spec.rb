# -*- coding: utf-8 -*-
require 'spec_helper'

describe "静态页面" do

  subject { page }

  describe "主页" do
    before { visit root_path }
    it { should have_title(full_title('')) }
    it { should have_content('电设') }
  end

  describe "关于" do
    before { visit about_path }
    it { should have_title(full_title('关于')) }
  end

  describe "文档" do
    before { visit doc_path }
    it { should have_title(full_title('文档')) }
  end

  describe "赛事" do
    before { visit events_path }
    it { should have_title(full_title('赛事')) }
  end

  describe "通知" do
    before { visit informs_path }
    it { should have_title(full_title('通知')) }
  end
end
