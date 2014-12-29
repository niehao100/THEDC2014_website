# -*- coding: utf-8 -*-
# == Schema Information
#
# Table name: memberships
#
#  id         :integer          not null, primary key
#  team_id    :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Membership do
  let(:user) { FactoryGirl.create(:user) }
  let(:team) { FactoryGirl.create(:team) }
  let(:membership) { team.memberships.build(user_id: user.id) }

  subject { membership }

  it { should be_valid }

  it { should respond_to(:user) }
  it { should respond_to(:team) }
  its(:user) { should eq user }
  its(:team) { should eq team }

  describe "没有user_id时" do
    before { membership.user_id = nil}
    it { should_not be_valid }
  end

  describe "没有team_id时" do
    before { membership.team_id = nil}
    it { should_not be_valid }
  end
end
