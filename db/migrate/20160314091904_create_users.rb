class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :password
      t.string :auth_token

      t.timestamps null: false
    end
  end
end
