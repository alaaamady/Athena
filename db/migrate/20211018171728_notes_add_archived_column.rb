class NotesAddArchivedColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :notes, :archived, :boolean, default: false
  end
end
