class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :username
      t.string :email
      t.text :content
      t.references :cause, null: false, foreign_key: true

      t.timestamps
    end
  end
end
