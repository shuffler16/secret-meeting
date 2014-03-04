class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.references :organizer, index: true

      t.timestamps
    end
  end
end
