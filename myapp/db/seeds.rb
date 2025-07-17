# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "================ダミー作成開始================="

# Round１テスト用データ
if Article.count < 50_000
  50000.times do |i|
    Article.create(
      title: "タイトルだよ！#{i}",
      body: "本文だぞ！！！！！！#{i}"
    )
  end
end

Article.find_or_create_by!(title: "solrベンチマーク用") do |article|
  article.body = "特別投稿: SuperUniqueKeyword2025"
end

puts "レコード作成完了 #{Article.count} articles"

# Round２テスト用データ
Product.find_or_create_by!(name: "スマートフォン") do |product|
  product.description = "高性能スマートフォンです"
end

Product.find_or_create_by!(name: "スマホケース") do |product|
  product.description = "おしゃれなスマホケースです"
end


puts "レコード作成完了 #{Product.count} products"
puts "================ダミー作成完了================="