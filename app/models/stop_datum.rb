# == Schema Information
#
# Table name: stop_data
#
#  id            :bigint(8)        not null, primary key
#  station_name  :string
#  stop_name     :string
#  long          :float
#  lat           :float
#  stop_id       :integer
#  map_id        :integer
#  direction_idt :string
#  abs_km        :float
#  trdr          :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class StopDatum < ApplicationRecord
end
