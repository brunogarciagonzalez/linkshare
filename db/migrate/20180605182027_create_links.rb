class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.string :url
      t.boolean :admin_deactivation, default: false

      t.timestamps
    end
  end
end
