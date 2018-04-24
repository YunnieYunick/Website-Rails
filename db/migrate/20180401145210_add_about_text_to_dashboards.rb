class AddAboutTextToDashboards < ActiveRecord::Migration[5.0]
  def change
    add_column :dashboards, :about_text, :text
  end
end
