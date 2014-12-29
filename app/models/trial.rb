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

class Trial < ActiveRecord::Base
  belongs_to :period
  belongs_to :team
end
