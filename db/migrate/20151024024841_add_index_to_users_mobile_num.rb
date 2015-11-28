class AddIndexToUsersMobileNum < ActiveRecord::Migration
  def change
  	  	add_index :users, :mobile_num, unique: true
  end
end
