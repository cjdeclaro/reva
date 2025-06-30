class CreateNpsScores < ActiveRecord::Migration[8.0]
  def change
    create_table :nps_scores do |t|
      t.string :company_name
      t.date :date
      t.integer :promoters_count
      t.integer :passives_count
      t.integer :detractors_count

      t.timestamps
    end
  end
end
