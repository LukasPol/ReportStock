class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports, &:timestamps
  end
end
