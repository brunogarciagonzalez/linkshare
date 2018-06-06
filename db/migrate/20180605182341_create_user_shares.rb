class CreateUserShares < ActiveRecord::Migration[5.1]
  def change
    create_table :user_shares do |t|
      t.integer :user_id
      t.integer :review_id
      t.integer :link_id
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
