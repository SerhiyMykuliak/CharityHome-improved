class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :cause, null: false, foreign_key: true
      
      t.decimal :amount, null: false, precision: 10, scale: 2
      t.string :status, null: false, default: "pending"
      t.string :username
      t.string :email
      t.text :description

      t.timestamps
    end
  end
end
