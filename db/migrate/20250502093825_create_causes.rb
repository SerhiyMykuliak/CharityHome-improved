class CreateCauses < ActiveRecord::Migration[7.1]
  def change
    create_table :causes do |t|
      t.string :title
      t.text :description
      t.string :short_description
      t.decimal :goal_amount
      t.decimal :collected_amount
      t.string :status
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
