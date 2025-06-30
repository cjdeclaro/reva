namespace :reviews do
  desc "Import reviews from CSV"
  task import: :environment do
    require "csv"

    path = ENV["FILE"] || "public/reviews.csv"
    puts "Importing from #{path}..."

    CSV.foreach(path, headers: true) do |row|
      rating_value = row["rating"].to_i

      if rating_value > 0 && rating_value <= 5
        Review.find_or_create_by!(
          company_name: row["company_name"].strip,
          channel: row["channel"].strip,
          review_date: row["date"],
          title: row["title"] || "",
          description: row["description"],
          rating: rating_value
        )
      else
        puts "Skipping review creation due to invalid rating: #{rating_value}"
      end
    end
    puts "Import complete."
  end
end
