namespace :reviews do
  desc "Import reviews from CSV"
  task import: :environment do
    require "csv"

    path = ENV["FILE"] || "public/reviews.csv"
    puts "Importing from #{path}..."

    CSV.foreach(path, headers: true) do |row|
      Review.find_or_create_by!(
        company_name: row["company_name"].strip,
        channel: row["channel"].strip,
        review_date: row["date"],
        title: row["title"],
        description: row["description"],
        rating: row["rating"].to_i
      )
    end
    puts "Import complete."
  end
end
