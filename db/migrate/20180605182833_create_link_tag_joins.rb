class CreateLinkTagJoins < ActiveRecord::Migration[5.1]
  def change
    create_table :link_tag_joins do |t|
      t.integer :link_id
      t.integer :tag_id
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
