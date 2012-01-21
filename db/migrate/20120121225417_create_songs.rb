class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :sid
      t.string :artist
      t.string :title
      t.string :album
      t.string :released

      t.timestamps
    end
  end
end
