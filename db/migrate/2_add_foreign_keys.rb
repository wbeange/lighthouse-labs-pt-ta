class AddForeignKeys < ActiveRecord::Migration
  def change
    change_table :movies do |t|
      t.references :user
    end

    change_table :reviews do |t|
      t.references :user
      t.references :movie
    end
  end
end
