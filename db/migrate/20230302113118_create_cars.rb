class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :name
      t.string :description
      t.float :price
      t.float :test_drive_fee
      t.string :model
      t.date :year
      t.json :image_data, null: false, default: {}

      t.timestamps
    end
  end
end
