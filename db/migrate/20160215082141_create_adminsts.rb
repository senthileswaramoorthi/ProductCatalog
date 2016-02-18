class CreateAdminsts < ActiveRecord::Migration
  def change
    create_table :adminsts do |t|
      t.string :username
      t.string :oldpass
      t.string :newpass

      t.timestamps null: false
    end
  end
end
