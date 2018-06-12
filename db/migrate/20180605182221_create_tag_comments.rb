class CreateTagComments < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_comments do |t|
      t.integer :tag_id
      t.integer :tag_commenter_id
      t.text :content
      t.boolean :user_deactivation, default: false
      t.boolean :admin_deactivation, default: false

      t.timestamps
    end
  end
end
