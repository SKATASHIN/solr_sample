namespace :solr do
  desc "round1 Reindex"
  task reindex_article: :environment do
    puts "================reindex_article開始================="
    Article.reindex
    puts "================reindex_article完了================="
  end

  desc "round2 Reindex"
  task reindex_product: :environment do 
    puts "================reindex_product開始================="
    Product.reindex
    puts "================reindex_product完了================="
  end
end