class CreateVolunteers < ActiveRecord::Migration[7.1]
  def change
    create_table :volunteers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.string :city
      t.text :description
      t.date :birth_date
      t.string :facebook_url
      t.string :instagram_url
      t.string :twitter_url

      t.timestamps
    end
  end
end
