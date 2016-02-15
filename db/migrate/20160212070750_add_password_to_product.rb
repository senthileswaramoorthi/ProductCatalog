class AddPasswordToProduct < ActiveRecord::Migration
  def change
    add_column :products, :password, :string
  end
end
