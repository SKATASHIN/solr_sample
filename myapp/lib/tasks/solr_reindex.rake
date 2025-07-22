namespace :solr do
  desc "round1 Reindex"
  task reindex_round_one: :environment do
    puts "================reindex_round_one開始================="
    RoundOne.reindex
    puts "================reindex_round_one完了================="
  end

  desc "round2 Reindex"
  task reindex_round_two: :environment do 
    puts "================reindex_round_two開始================="
    RoundTwo.reindex
    puts "================reindex_round_two完了================="
  end
end