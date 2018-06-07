class CreateReviewComments < ActiveRecord::Migration[5.1]
  def change
    create_table :review_comments do |t|
      t.integer :review_id
      t.integer :review_commenter_id
      t.text :content
      t.boolean :user_deactivation, default: false
      t.boolean :admin_deactivation, default: false

      t.timestamps
    end
  end
end
