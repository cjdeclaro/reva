class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.string :company_name
      t.string :channel
      t.integer :rating
      t.date :review_date
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
