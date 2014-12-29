# -*- coding: utf-8 -*-
require 'spec_helper'
describe "用户页面" do
  subject { page }
  let(:user) { FactoryGirl.create(:user)}
  describe "index" do
    before(:each) do
      visit users_path
    end

    it { should have_title('所有选手') }
    it { should have_content('所有选手') }

    describe "pagination" do
      before(:all) { 31.times { FactoryGirl.create(:user)}}
      after(:all) { User.delete_all}
      
      it { should have_selector('div.pagination') }

      it "should list all users" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end
  end

  describe "个人页面" do
    before { visit user_path(user.id)}

    it { should have_title(user.name) }
    it { should have_content(user.name) }

  end

  describe "注册页面" do
    before {visit signup_path}

    it { should have_selector('h1', text: '选手注册') }
    it { should have_title(full_title('选手注册'))}

    let(:submit) { "注册" }

    describe "登录用户" do 
      let(:user) { FactoryGirl.create(:user) }
      before do
        rspec_sign_in user
      end 
      
      describe "访问注册页"  do  # 这个测试似乎无论改不改user c/new都会通过，奇怪！
        before { visit signup_path }
        it { should have_title(full_title('')) }
      end
    end
    
    describe "非法信息" do
      it "不应创建选手" do
        expect { click_button submit }.not_to change(User, :count)
      end
      
      describe "点击注册后" do
        before { click_button submit }
        
        it { should have_title('选手注册')}
        it { should have_content('错误')}
        it { should have_error_msg('失败') }
      end
    end
    describe "合法信息" do
      before do
        fill_in "姓名",		with: "博丽灵梦"
        fill_in "邮箱",		with: "shit_fuck@163.com"
        fill_in "密码",		with: "foobar"
        fill_in "密码确认",	with: "foobar"
        fill_in "班级",	with: "无210"
        fill_in "系别",	with: "电子系"
      end

      it "应该创建选手" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
      describe "注册后" do
        before { click_button submit }
        let(:user) { User.find_by(email: "shit_fuck@163.com")}
        
        it { should have_link('登出') }
        it { should have_title(user.name)}
        it { should have_success_msg('欢迎')  }
      end
    end
  end

  describe "修改个人信息页面" do
    let(:user) { FactoryGirl.create(:user) }

    describe "登入前" do
      before { visit edit_user_path(user)}
      it { should_not have_content("修改你的个人资料") }
      it { should_not have_title("修改个人信息") }
    end

    describe "登入后" do
      before do
        rspec_sign_in user
        visit edit_user_path(user)
      end
      
      it { should have_content("修改你的个人资料") }
      it { should have_title("修改个人信息") }
      it { should have_button('提交修改') }

      describe "没有旧密码" do
        before { click_button "提交修改" }
        
        it { should have_error_msg('错误') }
      end
      
      describe "填入部分信息后" do
        let(:new_name) { "黑桐干也"}
        let(:new_email) { "shikimylove@example.com"}
        let(:old_gender) { user.gender }
        let(:old_class) { user.class }
        let(:old_department) { user.department }
        before do
          fill_in "旧密码",		with: user.password
          fill_in "姓名", with: new_name
          fill_in "邮箱", with: new_email
          fill_in "密码",		with: user.password
          fill_in "密码确认",	with: user.password
          click_button "提交修改"
        end
        
        it { should have_title('黑桐干也') }
        it { should have_success_msg('修改成功') }
        it { should have_link('登出', href: signout_path) }
        specify { expect(user.reload.name).to eq new_name }
        specify { expect(user.reload.email).to eq new_email }
        specify { expect(user.reload.gender).to eq old_gender }
        specify { expect(user.reload.class).to eq old_class }
        specify { expect(user.reload.department).to eq old_department }
      end
    end
  end

  describe "删除账户页面" do
    let(:user) { FactoryGirl.create(:user) }

    describe "登入前" do
      before { visit delete_user_path(user)}
      it { should_not have_content("删除账户") }
      it { should_not have_title("删除账户") }
    end

    describe "登入后" do
      before do
        rspec_sign_in user
        visit delete_user_path(user)
      end
      
      it { should have_content("删除账户") }
      it { should have_title("删除账户") }
      it { should have_button('确认') }

      describe "没有旧密码" do
        before { click_button "确认" }
        
        it { should have_error_msg('错误') }
      end
    end
  end
end
