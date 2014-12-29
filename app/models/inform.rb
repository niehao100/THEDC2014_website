# == Schema Information
#
# Table name: informs
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#

class Inform < ActiveRecord::Base
  scope :recent, -> { where("updated_at > :ago", {ago: DateTime.now.ago(10.days) }).order("updated_at DESC")}
  validates :title, presence: true
  validates :content, presence: true
end
