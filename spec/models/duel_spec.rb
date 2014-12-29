# -*- coding: utf-8 -*-
# == Schema Information
#
# Table name: duels
#
#  id         :integer          not null, primary key
#  a_id       :integer
#  b_id       :integer
#  winner_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  event_id   :integer
#

require 'spec_helper'

describe Duel do
  let(:team_a) { FactoryGirl.create(:team) }
  let(:team_b) { FactoryGirl.create(:team) }
  let(:duel) { Duel.create_duel!(team_a,team_b) }

  subject {duel}

  it { should be_valid }
  it { should respond_to(:a) }
  it { should respond_to(:b) }
  its(:a) { should eq team_a }
  its(:b) { should eq team_b }

  describe "没有a_id时" do
    before { duel.a_id = nil}
    it { should_not be_valid }
  end

  describe "没有b_id时" do
    before { duel.b_id = nil}
    it { should_not be_valid }
  end

  describe "a_id = b_id时" do
    before { duel.a_id = duel.b_id}
    it { should_not be_valid }
  end

  describe "每个队伍都" do
    describe "应包含这个比赛" do
     subject {team_a} 
      its(:duels) { should include(duel) }

     subject {team_b} 
      its(:duels) { should include(duel) }
    end
  end
end
