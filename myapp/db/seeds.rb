# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Creating dummy!!!"

10000.times do |i|
  Article.create(
    title: "タイトルだよ！#{i}",
    body: "本文だぞ！！！！！！#{i}"
  )
end

Article.create(
  title: "solrベンチマーク用",
  body: "特別投稿: SuperUniqueKeyword2025"
)

puts "created #{Article.count} articles"


