namespace :round2 do
  desc "SQLとSolrの複数フィールド検索（title+body）速度比較"
  task speed: :environment do
    require 'benchmark'
    puts "================検証開始====================="

    query = 'SuperUniqueKeyword2025'

    db_count = RoundTwo.count
    solr_count = RoundTwo.search { keywords('*') }.total

    puts "DBレコード数: #{db_count}件"
    puts "Solrインデックス数: #{solr_count}件"

    sql_results = []
    solr_results = []

    sql_time = Benchmark.measure {
      sql_results = RoundTwo.where('title LIKE ? OR body LIKE ?', "%#{query}%", "%#{query}%").to_a
    }.real

    solr_time = Benchmark.measure {
      solr_results = RoundTwo.search {
        fulltext(query) { fields(:title, :body) }
      }.results.to_a
    }.real

    puts "SQL実行時間:  #{sql_time.round(4)} 秒"
    puts "Solr実行時間:  #{solr_time.round(4)} 秒"

    puts "SQL結果: #{sql_results.size}件"
    puts "Solr結果: #{solr_results.size}件"


    puts "================検証終了====================="
  end
end





