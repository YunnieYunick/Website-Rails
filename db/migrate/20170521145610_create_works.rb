class CreateWorks < ActiveRecord::Migration[5.0]
  def change
    create_table :works do |t|
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
