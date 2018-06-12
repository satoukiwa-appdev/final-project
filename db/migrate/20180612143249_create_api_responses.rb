class CreateApiResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :api_responses do |t|
      t.json :payload

      t.timestamps
    end
  end
end
