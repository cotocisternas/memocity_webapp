class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :last_name
      t.string :email
      t.string :mobile_num
      t.string :city
      t.string :country
      t.string :address
      t.date :birth_date

      t.timestamps null: false
    end
  end
end
