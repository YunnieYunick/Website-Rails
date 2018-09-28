class CreateDashboards < ActiveRecord::Migration[5.0]
  def change
    create_table :dashboards do |t|
      t.string :site_name
      t.text :site_description

      t.timestamps
    end
  end
end
