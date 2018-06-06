class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :reviewer_id
      t.integer :link_id
      t.text :content
      t.integer :rating
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
