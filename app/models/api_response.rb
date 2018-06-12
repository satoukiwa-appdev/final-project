# == Schema Information
#
# Table name: api_responses
#
#  id         :bigint(8)        not null, primary key
#  payload    :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ApiResponse < ApplicationRecord
end
