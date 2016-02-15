class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :cat_name
      t.string :parent_id

      t.timestamps null: false
    end
  end
end
