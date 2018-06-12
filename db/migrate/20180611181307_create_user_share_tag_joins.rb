class CreateUserShareTagJoins < ActiveRecord::Migration[5.1]
  def change
    create_table :user_share_tag_joins do |t|
      t.integer :user_share_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
