class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :image
      t.string :uid
      t.string :token
      t.string :refresh_token
      t.datetime :expires_at

      t.timestamps
    end
  end
end
