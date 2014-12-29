# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#  due_date    :date
#

class Event < ActiveRecord::Base
  has_many :teams, through: :trials
  has_many :periods, dependent: :destroy
  has_many :duels, dependent: :destroy
  has_many :trials, through: :periods

  validates :name, presence: true

  def is_end
    Date.today > due_date
  end

end
