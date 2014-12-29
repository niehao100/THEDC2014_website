# -*- coding: utf-8 -*-
require 'spec_helper'

describe "队伍页面" do
  subject {page}
  describe "注册页面" do
    before {visit new_team_path}


    let(:submit) { "确认" }

    describe "队中人" do
      let(:team) {FactoryGirl.create(:team)}
      let(:user) { FactoryGirl.create(:user) }
      before do
      end
      describe "不可加" do
        before { visit new_team_path }
        it { should_not have_title(full_title('创建队伍'))}
      end 
    end
    describe "登录用户" do 
      let(:user) { FactoryGirl.create(:user) }
      before do
        rspec_sign_in user
        visit new_team_path
      end 

      it { should have_selector('h1', text: '创建') }
      it { should have_title(full_title('创建队伍'))}
      describe "非法信息" do
        it "不应创建队伍" do
          expect { click_button submit }.not_to change(Team, :count)
        end
        
        describe "点击注册后" do
          before { click_button submit }
          
          it { should have_title('创建队伍')}
          it { should have_content('错误')}
          it { should have_error_msg('失败') }

        end
      end
      describe "合法信息" do
        before do
          fill_in "队名",		with: "博丽灵梦"
        end

        it "应该创建团队" do
          expect { click_button submit }.to change(Team, :count).by(1)
        end

        describe "后" do
          before { click_button submit }
          
          it { should have_success_msg('成功')  }

          describe "user.team" do
            subject { user.team }
            its(:leader_id) { should eq user.id }
            its(:members) { should include user }
          end
        end
      end
    end
  end

  describe "修改页面" do
    let(:team) { FactoryGirl.create(:team) }
    let(:user) { FactoryGirl.create(:user) }

    describe "登入前" do
      before { visit edit_team_path(team)}
      it { should_not have_content("管理你的团队") }
      it { should_not have_title("管理团队信息") }
    end

    describe "登入后" do
      describe "非组内用户" do
        before do
          rspec_sign_in user
          visit edit_team_path(team)
        end
        it { should_not have_content("管理你的团队") }
        it { should_not have_title("管理团队信息") }
      end

      describe "组内非队长用户" do
        before do
          team.add_member!(user)
          rspec_sign_in user
          visit edit_team_path(team)
        end
        it { should_not have_content("管理你的团队") }
        it { should_not have_title("管理团队信息") }
      end
      
      describe "队长" do
        before do
          team.add_member!(user)
          team.leader_id = user.id
          team.save
          rspec_sign_in user
          visit edit_team_path(team)
        end
        it { should have_content("管理你的团队") }
        it { should have_title("管理团队信息") }
        
        describe "填入信息后" do
          let(:new_name) { "羞耻博物馆" }
          before do
            fill_in "队名", with: new_name
            click_button  "提交修改"
          end
          
          it { should have_title( new_name ) }
          it { should have_success_msg('修改成功') }
          specify { expect(team.reload.name).to eq new_name }
        end
      end
    end
  end

  describe "解散队伍" do
    let(:team) { FactoryGirl.create(:team) }
    let(:user) { FactoryGirl.create(:user) }

    describe "登入前" do
      before { visit edit_team_path(team)}
      it { should_not have_content("解散队伍") }
      it { should_not have_title("解散队伍") }
    end

    describe "登入后" do
      describe "非组内用户" do
        before do
          rspec_sign_in user
          visit delete_team_path(team)
        end
        it { should_not have_content("解散队伍") }
        it { should_not have_title("解散队伍") }
      end

      describe "组内非队长用户" do
        before do
          team.add_member!(user)
          rspec_sign_in user
          visit delete_team_path(team)
        end
        it { should_not have_content("解散队伍") }
        it { should_not have_title("解散队伍") }
      end
      
      describe "队长" do
        before do
          team.add_member!(user)
          team.leader_id = user.id
          team.save
          rspec_sign_in user
          visit delete_team_path(team)
        end
        it { should have_content("解散队伍") }
        it { should have_title("解散队伍") }

        describe "提交请求" do
          
         specify { expect { click_button  "确认" }.to change(Team, :count).by(-1) }
        end
        
        describe "提交请求后" do
          before {click_button  "确认"}

          it { should  have_title(full_title('')) }
        end
      end
    end
  end
end
