class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :reviewer_id
      t.integer :link_id
      t.integer :user_share_id
      t.text :content
      t.integer :rating
      t.boolean :user_deactivation, default: false
      t.boolean :admin_deactivation, default: false

      t.timestamps
    end
  end
end
