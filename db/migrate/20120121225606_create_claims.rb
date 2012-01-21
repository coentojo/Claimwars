class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.string :uid
      t.string :sid
      t.datetime :listened_at

      t.timestamps
    end
  end
end
