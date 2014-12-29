# == Schema Information
#
# Table name: trials
#
#  id         :integer          not null, primary key
#  team_id    :integer
#  passed     :boolean          default(TRUE)
#  created_at :datetime
#  updated_at :datetime
#  period_id  :integer
#  start_time :datetime
#  end_time   :datetime
#

require 'spec_helper'

describe Trial do
  pending "add some examples to (or delete) #{__FILE__}"
end
