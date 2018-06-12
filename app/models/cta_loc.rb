# == Schema Information
#
# Table name: cta_locs
#
#  id         :bigint(8)        not null, primary key
#  rn         :integer
#  tmst       :datetime
#  destst     :integer
#  destnm     :string
#  trdr       :string
#  nextstaid  :integer
#  nextstpid  :integer
#  nextstanm  :string
#  prdt       :datetime
#  arrt       :datetime
#  isapp      :integer
#  isdly      :integer
#  flags      :integer
#  lat        :float
#  lon        :float
#  heading    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CtaLoc < ApplicationRecord
    
    
    # Class to convert to csv
    def self.to_csv
        CSV.generate do |csv|
        # column_names returns column name in array
            csv << column_names
            all.each do |location|
                # attributes returns column name and its value in hash
                # col name becomes key, value = value
                # ex: {"id"=>1, "price"=>3000, ... }
                # values_at gives value for given key and returns as array
                # so the row below returns the value for the given column_names
                csv << location.attributes.values_at(*column_names)
            end
        end
    end
    
    
end
