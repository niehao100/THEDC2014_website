# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  scope :recent, -> { where("created_at > :ago", {ago: DateTime.now.ago(10.days) })}
  belongs_to :user
  has_many :replies

  validates :title, presence: true
  validates :content, presence: true

  def self.search(search, page)
    if search
      self.where('title LIKE :search OR content LIKE :search', {search: "%#{search}%"}).order("created_at DESC").page(page).per(10)
    else
      self.order("created_at DESC").page(page).per(10)
    end
  end
end
