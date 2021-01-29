class CreateItemTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :item_types do |t|
      t.string :short_code
      t.string :name
         t.timestamps null: false
    end
  end
end
