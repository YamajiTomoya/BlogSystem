class AddCsvDataToUserStatistics < ActiveRecord::Migration[5.2]
  def change
    add_column :user_statistics, :csv_data, :text
  end
end
