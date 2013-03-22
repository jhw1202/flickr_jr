class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |u|
      u.string :email, :name, :password
      u.timestamps
    end
  end
end
