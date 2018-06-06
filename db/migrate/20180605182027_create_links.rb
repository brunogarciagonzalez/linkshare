class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.string :url
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
