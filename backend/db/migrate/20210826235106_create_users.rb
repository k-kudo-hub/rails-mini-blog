class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name,      null: false, limit: 20
      t.string :email,     null: false
      t.string :password_digest, null: false
      t.string :introduce, limit: 250
      t.text :picture
      t.text :cover
      t.string :uid
      t.string :provider,  limit: 10
      t.timestamps         null: false
      t.index :email, unique: true
    end
  end
end
