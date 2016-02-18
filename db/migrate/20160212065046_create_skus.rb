class CreateSkus < ActiveRecord::Migration
  def change
    create_table :skus do |t|
      t.string :i_id
      t.string :c_name
      t.string :name
      t.string :value
      t.string :unit
      t.string :p_id

      t.timestamps null: false
    end
  end
end
