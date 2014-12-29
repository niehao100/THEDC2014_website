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

class Duel < ActiveRecord::Base
  include ActiveModel::Validations
  belongs_to :a, class_name: "Team"
  belongs_to :b, class_name: "Team"
  belongs_to :event

  validates :a_id, presence: true
  validates :b_id, presence: true
  validate do |duel|
    duel.errors.add(:base, '参赛两队不能相同') unless duel.a_id != duel.b_id
  end

  def winner?(user)
     winner_id == user.id
  end

  def a_win
    self.winner_id = a_id
    self.save
    b.survived = false
    b.save
  end

  def a_win?
    winner?(a)
  end

  def b_win
    self.winner_id = b_id
    self.save
    a.survived = false
    a.save
  end

  def b_win?
    winner?(b)
  end

  def rival(team)
    id = team.id
    if id == a.id
      return b
    elsif id == b.id
      return a
    end
  end

  def self.create_duel!(a,b)
    self.create!(a_id: a.id, b_id: b.id)
  end
end
