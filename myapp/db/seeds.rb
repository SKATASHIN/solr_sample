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
if RoundOne.count < 30_000
  1.upto(30_000) do |i|
    RoundOne.create(
      body: "本文だぞ！！！！！！#{i}"
    )
  end

  # ヒット用データ
  1.upto(25) do |i|
    RoundOne.create(
      body: "特別投稿: SuperUniqueKeyword2025 #{i}"
    )
  end
end

puts "レコード作成完了 #{RoundOne.count} RoundOne"

# Round２テスト用データ
# if RoundTwo.count < 30_025
#   # A: titleのみ一致（10件）
#   1.upto(10) do |i|
#     RoundTwo.create!(
#       title: "SuperUniqueKeyword2025 を含むタイトル #{i}",
#       body: "これは一致しない本文です #{i}"
#     )
#   end

#   # B: bodyのみ一致（10件）
#   1.upto(10) do |i|
#     RoundTwo.create!(
#       title: "一致しないタイトル #{i}",
#       body: "これは SuperUniqueKeyword2025 を含む本文です #{i}"
#     )
#   end

#   # C: 両方一致（5件）
#   1.upto(5) do |i|
#     RoundTwo.create!(
#       title: "SuperUniqueKeyword2025 を含むタイトル #{i}",
#       body: "SuperUniqueKeyword2025 を含む本文 #{i}"
#     )
#   end

#   # D: 両方一致しない（10_000件）
#   1.upto(30_000) do |i|
#     RoundTwo.create!(
#       title: "通常のタイトル #{i}",
#       body: "通常の本文 #{i}"
#     )
#   end
# end

puts "レコード作成完了 #{RoundTwo.count} RoundTwo"

# Round３テスト用データ
if RoundThree.count < 30_000
  1.upto(30_000) do |i|
    RoundThree.create!(
      title: "タイトル #{i}",
      body: "本文 #{i}",
      created_at: rand(3.years.ago..Time.now),
      updated_at: Time.now
    )
  end
end

puts "レコード作成完了: #{RoundThree.count} RoundThree"

puts "================ダミー作成完了================="