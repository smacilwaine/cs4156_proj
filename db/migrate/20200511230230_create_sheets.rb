class CreateSheets < ActiveRecord::Migration[5.2]
  def change
    create_table :sheets do |t|
      t.string :name
      t.string :attachment

      t.timestamps
    end
  end
end
