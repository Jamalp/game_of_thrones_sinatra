class AddHouseIdToPeoplesTable < ActiveRecord::Migration
  def up
    # add_column :people, :house_id, :integer
    # ^--Add column to the people table, make it a house column
    # and the value will be a number.
    change_table :people do |t|
      t.references :house
    end
  end

  def down
    remove_column :people, :house_id
  end
end
