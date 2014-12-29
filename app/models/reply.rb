# == Schema Information
#
# Table name: replies
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Reply < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :content, presence: true
end
