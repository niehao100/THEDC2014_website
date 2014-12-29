# == Schema Information
#
# Table name: applies
#
#  id         :integer          not null, primary key
#  team_id    :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Apply < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  validates :team_id, presence: true
  validates :user_id, presence: true

  def decline!
    self.destroy
  end

  def cancel!
    self.destroy
  end
end
