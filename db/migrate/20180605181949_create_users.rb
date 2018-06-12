class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.boolean :user_deactivation, default: false
      t.boolean :admin_deactivation, default: false
      t.timestamps
    end
  end
end
