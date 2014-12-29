# == Schema Information
#
# Table name: docs
#
#  id                    :integer          not null, primary key
#  title                 :string(255)
#  description           :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  doc_file_file_name    :string(255)
#  doc_file_content_type :string(255)
#  doc_file_file_size    :integer
#  doc_file_updated_at   :datetime
#

class Doc < ActiveRecord::Base
  has_attached_file :doc_file,
  :path => ":rails_root/public/system/docs/:id/:filename", :url => "/system/docs/:id/:filename"
  validates :title, presence: true, length: { maximum: 20 }
  validates_attachment_presence :doc_file, on: :create
end
