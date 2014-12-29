# -*- coding: utf-8 -*-
# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  survived   :boolean          default(TRUE)
#  created_at :datetime
#  updated_at :datetime
#  leader_id  :integer
#  group      :string(255)
#

require 'spec_helper'

describe Team do
  before { @team = Team.new(name: "甜梅号")}
  subject { @team }
  it { should respond_to(:name) }

  it { should respond_to(:memberships) }
  it { should respond_to(:members) }

  it { should respond_to(:add_member!) }
  it { should respond_to(:invite_member) }
  it { should respond_to(:kick_member!) }

  describe "增加成员" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      @team.save
      @team.add_member!(user)
    end

    its(:members) { should include(user) }

    describe "删除成员" do
      before { @team.kick_member!(user)} 
      its(:members) { should_not include(user) }
    end
  end
end
