class CreateAdmis < ActiveRecord::Migration
  def change
    create_table :admis do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :re_enterpassword

      t.timestamps null: false
    end
  end
end
