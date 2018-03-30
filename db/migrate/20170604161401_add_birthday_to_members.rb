class AddBirthdayToMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :birthday, :date
  end
end
