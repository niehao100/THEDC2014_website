# == Schema Information
#
# Table name: periods
#
#  id           :integer          not null, primary key
#  event_id     :integer
#  start_time   :datetime
#  end_time     :datetime
#  created_at   :datetime
#  updated_at   :datetime
#  total_number :integer          default(0)
#

require 'spec_helper'

describe Period do
  pending "add some examples to (or delete) #{__FILE__}"
end
