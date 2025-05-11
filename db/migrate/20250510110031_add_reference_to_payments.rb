class AddReferenceToPayments < ActiveRecord::Migration[7.1]
  def change
    add_column :payments, :reference, :string
    add_index :payments, :reference
  end
end
