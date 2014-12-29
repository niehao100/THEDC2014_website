# -*- coding: utf-8 -*-
require 'spec_helper'

describe "认证" do
  subject { page }

  describe "登入页面" do
    before { visit signin_path }

    it { should have_content('登入') }
    it { should have_title('登入') }

    describe "非法信息" do
      before {click_button "登入"}

      it { should have_title('登入') }
      it { should have_error_msg('无效') }
    end
    describe "合法信息" do
      let(:user) { FactoryGirl.create(:user)} 
      before { rspec_sign_in(user)}

      it { should have_title(user.name) }
      #it { should have_link('Users', href: users_path) }
      it { should have_link('个人页面', href: user_path(user)) }
      it { should have_link('登出', href: signout_path) }
      it { should_not have_link('登入', href: signin_path) }
      
      describe "followed by signout" do
        before { click_link "登出"}
        it { should have_link('登入', href: signin_path)}
      end
    end
  end

  describe "未登录用户" do
    let(:user) { FactoryGirl.create(:user)}

    describe "User控制器" do
      describe "修改信息页" do
        before { visit edit_user_path(user)}
        it { should have_title('登入') }
        describe "登入后" do
            before { valid_signin(user) }
            
            it "应跳转至修改信息页" do
              expect(page).to have_title('修改个人信息')
            end
            
            describe "再次登入后" do
              before do 
                delete signout_path
                visit signin_path
                valid_signin(user)
              end
              
              it "应进入个人主页" do
                expect(page).to have_title(user.name)
              end
            end
          end
        describe "submitting to the update action" do
          before { patch user_path(user)}
          specify { expect(response).to redirect_to(signin_path) }
        end
      end

      describe "删除账户页面" do
        before { visit delete_user_path(user)}
        it { should have_title('登入') }
        describe "登入后" do
          before { valid_signin(user) }
          
          it "应跳转至修改信息页" do
            expect(page).to have_title('删除账户')
          end
          
          describe "再次登入后" do
            before do 
              delete signout_path
              visit signin_path
              valid_signin(user)
            end
            
            it "应进入个人主页" do
              expect(page).to have_title(user.name)
            end
          end
        end
      end
    end
  end

  describe "错误用户" do
    let(:user) { FactoryGirl.create(:user)}
    let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com")}
    before {rspec_sign_in user, no_capybara: true}
    
    describe "访问修改信息页" do
      before { visit edit_user_path(wrong_user)}
      it { should_not have_title(full_title('修改个人信息')) }
    end
    
    describe "submitting a PATCH request to the Users#update action" do
      before { patch user_path(wrong_user)}
      specify { expect(response).to redirect_to(root_path)}
    end
    
    describe "访问删除账户页" do
      before { visit delete_user_path(wrong_user)}
      it { should_not have_title(full_title('删除账户')) }
    end

    describe "submitting a delete request to the Users#destroy action" do
      before { delete user_path(wrong_user)}
      specify { expect(response).to redirect_to(root_path)}
    end
  end
end
