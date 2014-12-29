# -*- coding: utf-8 -*-
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  password_digest        :string(255)
#  department             :string(255)
#  from_class             :string(255)
#  gender                 :string(255)
#  remember_token         :string(255)
#  phone_num              :integer
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  id_num                 :integer
#  admin                  :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  has_secure_password

  has_one :membership, dependent: :destroy
  has_one :team, through: :membership

  has_many :posts, dependent: :destroy
  has_many :replies, dependent: :destroy

  has_many :invitations, dependent: :destroy
  has_many :applies, dependent: :destroy
  
  before_save { self.email.downcase! }

  validates :name, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :phone_num, presence: true
  validates_numericality_of :phone_num
  validates :gender, inclusion: %w(男 女)
  validates :department, presence: true
  validates :from_class, presence: true
  # 这里原来用的class，结果它是关键字，报的错误还特别奇葩，郁闷了一晚上
  validates :password, length: { minimum: 6 }, on: :create
  validates :password, confirmation: false, allow_blank: true, on: :update

  def self.search(search, page)
    if search
      User.where('name LIKE :search OR email LIKE :search', {search: "%#{search}%"}).order(:created_at).page(page)
    else
      User.all.order(:created_at).page(page)
    end
  end

  def clear_applies_and_invitations
    self.clear_applies
    self.clear_invitations
  end

  def clear_invitations
    if invitations.any?
      self.invitations.destroy_all
    end
  end

  def clear_applies
    if applies.any?
      self.applies.destroy_all
    end
  end

  def apply_to_team(team)
    if can_be_recircuit? && team.can_recircuit?
      applies.create!(team_id: team.id)
    end
  end

  def can_create_team?
    self.team.nil? # 为什么这么多self？我不知道。第9还是10章说ActiveRecord似乎有要求，还是我没看懂？
  end

  def has_team?
    !self.team.nil?
  end

  def leader? # 判断是不是领队，主要为了判断是否显示队伍页面的一些链接用
    has_team? && self.team.leader?(self)
  end
  
  def can_recircuit?
    self.leader? && self.team.can_recircuit?
  end

  def can_be_recircuit?
    self.team.nil?
  end

  def send_password_reset
    self.update_attribute(:password_reset_token, new_token)
    self.update_attribute(:password_reset_sent_at, Time.zone.now)
    UserMailer.password_reset(self).deliver
  end

  def new_token
    SecureRandom.urlsafe_base64
  end

  private

  def create_remember_token
    self.remember_token = encrypt_token(new_remember_token)
  end

end
