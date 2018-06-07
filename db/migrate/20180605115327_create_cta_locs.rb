class CreateCtaLocs < ActiveRecord::Migration[5.1]
  def change
    create_table :cta_locs do |t|
      t.integer :rn
      t.datetime :tmst
      t.integer :destst
      t.string :destnm
      t.string :trdr
      t.integer :nextstaid
      t.integer :nextstpid
      t.string :nextstanm
      t.datetime :prdt
      t.datetime :arrt
      t.integer :isapp
      t.integer :isdly
      t.integer :flags
      t.float :lat
      t.float :lon
      t.string :heading

      t.timestamps
    end
  end
end
