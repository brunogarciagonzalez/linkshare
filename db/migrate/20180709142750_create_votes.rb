class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :review_id
      t.integer :user_id
      t.boolean :helpful
    end
  end
end
