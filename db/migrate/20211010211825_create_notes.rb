class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.integer :id
      t.string :title
      t.string :content
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
