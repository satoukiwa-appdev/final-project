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
end
