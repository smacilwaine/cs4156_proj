class AddSheetIdToLectures < ActiveRecord::Migration[5.2]
  def change
    add_column :lectures, :sheet_id, :bigint
  end
end
