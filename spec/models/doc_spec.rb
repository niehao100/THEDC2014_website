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

require 'spec_helper'

describe Doc do
  pending "add some examples to (or delete) #{__FILE__}"
end
