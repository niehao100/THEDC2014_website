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

class Membership < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  validates :team_id, presence: true
  validates :user_id, presence: true
end
