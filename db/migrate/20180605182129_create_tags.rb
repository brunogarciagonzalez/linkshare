class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :title
      t.boolean :admin_deactivation, default: false

      t.timestamps
    end
  end
end
