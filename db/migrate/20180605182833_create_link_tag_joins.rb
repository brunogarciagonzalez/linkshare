class CreateLinkTagJoins < ActiveRecord::Migration[5.1]
  def change
    create_table :link_tag_joins do |t|
      t.integer :link_id
      t.integer :tag_id
      t.boolean :user_deactivation, default: false
      t.boolean :admin_deactivation, default: false

      t.timestamps
    end
  end
end
