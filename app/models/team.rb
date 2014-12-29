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

class Team < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user

  has_many :invitations, dependent: :destroy
  has_many :applies, dependent: :destroy

  has_many :trials, dependent: :destroy

  validates :name, presence: true,  length: { maximum: 20 }, uniqueness: { case_sensitive: false }
  validates :group, presence: true, inclusion: ["DSP组","单片机组","FPGA组"]

  def duels
    Duel.where("duels.a_id = :id OR duels.B_id = :id ", {id: id})
  end

  def posts
    users_id = []
    members.each do |member|
      users_id.push(member.id)
    end
    Post.where(user_id: users_id )
  end

  def self.search(search, page)
    if search
      Team.includes(:members).where('teams.name LIKE :search OR users.name LIKE :search', {:search => "%#{search}%"}).order(:created_at).page(page).per(10)
    else
      Team.all.order(:created_at).page(page).per(10)
    end
  end

  def invite_member(user)
    if can_recircuit?
      invitations.create!(user_id: user.id)
    end
  end
  
  def add_member!(user)
    if can_recircuit? && user.can_be_recircuit?
      memberships.create!(user_id: user.id)
      user.clear_applies_and_invitations
    end
  end

  def add_as_leader(user)
    add_member!(user)
    self.leader_id = user.id
    self.save
  end

  def survive
    self.survived = true
    self.save
  end

  def out
    self.survived = false
    self.save
  end

  def kick_member!(user)
    if !leader?(user)
      membership_to_kick = memberships.find_by(user_id: user.id)
      if membership_to_kick
        membership_to_kick.destroy
      end
    end
  end

  def member?(user)
    memberships.include?(user)
  end
  
  #def leader=(user)
  #  if member?(user)
  #    self.leader_id = user.id
  #  end
  #end
  # 似乎不能用

  def leader
    members.find_by(id: self.leader_id)
  end

  def leader?(user)
    user.id == self.leader_id
  end

  def full?
    t_members=self.members
    t_members.nil? || t_members.count >= 4
  end

  def can_recircuit?
    survived? && !full?
  end
end
