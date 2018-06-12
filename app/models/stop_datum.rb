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
    
    def self.to_csv
        CSV.generate do |csv|
        # column_names returns column name in array
            csv << column_names
            all.each do |product|
                # attributes returns column name and its value in hash
                # col name becomes key, value = value
                # ex: {"id"=>1, "price"=>3000, ... }
                # values_at gives value for given key and returns as array
                # so the row below returns the value for the given column_names
                csv << product.attributes.values_at(*column_names)
            end
        end
    end
    
    
end
