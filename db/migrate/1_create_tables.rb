class CreateTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :password_digest
      t.timestamps
    end

    create_table :movies do |t|
      t.string :title
      t.timestamps
    end

    create_table :reviews do |t|
      t.string :title
      t.string :description
      t.decimal :rating
      t.timestamps
    end
  end
end
