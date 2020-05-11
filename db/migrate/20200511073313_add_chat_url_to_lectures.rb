class AddChatUrlToLectures < ActiveRecord::Migration[5.2]
  def change
    add_column :lectures, :chat_url, :string
  end
end
