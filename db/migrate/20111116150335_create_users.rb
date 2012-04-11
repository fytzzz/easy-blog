class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :hashed_password
      t.string :name
      t.string :email
      t.integer :admin
      t.string :status
      t.datetime :last_login_on
      t.string :language
      t.integer :auth_source_id
      t.string :types
      t.string :identity_url
      t.string :mail_notification
      t.string :salt

      t.timestamps
    end
  end
end
