# -*- coding: utf-8 -*-
# == Schema Information
#
# Table name: periods
#
#  id           :integer          not null, primary key
#  event_id     :integer
#  start_time   :datetime
#  end_time     :datetime
#  created_at   :datetime
#  updated_at   :datetime
#  total_number :integer          default(0)
#

class Period < ActiveRecord::Base
  include ActiveModel::Validations
 
  has_many :teams, through: :trials
  has_many :trials, dependent: :destroy
  belongs_to :event

  validates :total_number, numericality: { greater_than: 0 }
  validate do |period|
    period.errors.add(:base, '开始时间不能大于结束时间!') if period.start_time > period.end_time
  end

  def full?
    trials.count >= total_number
  end

  def addin_team(team)
    if team.survived? && !full? && !self.event.teams.include?(team)
      lapse = (self.end_time - self.start_time) / total_number
      trial_end = self.end_time - self.trials.count * lapse
      trial_start = trial_end - lapse
      trials.create!(team_id: team.id, start_time: trial_start, end_time: trial_end)
    end
  end

  def remove_team(team)
    trial = self.trials.find_by(team_id: team.id)
    if !trial.nil?
      trial.destroy
    end
  end
end
