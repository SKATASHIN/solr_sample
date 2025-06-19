namespace :speed_results do
  desc "Compare SQL LIKE and Solr full-text search"
  task search: :environment do
    require 'benchmark'

    query = 'SuperUniqueKeyword2025'
    puts "検索ワード: #{query}"

    Benchmark.bm do |x|
      # 前後どうでもいい部分一致にする
      x.report("SQL LIKE検索（body）") do
        @sql_results = Article.where("body LIKE ?", "%#{query}%").to_a
      end

      x.report("Solr全文検索（body）") do
        # Solrで全文検索を実行
        @solr_results = Article.search do
          fulltext query do
            fields(:body)
          end
        end.results
      end
    end
    puts ""
    puts "検索結果件数"
    puts "SQLヒット件数   : #{@sql_results.size}"
    puts "Solrヒット件数   : #{@solr_results.size}"
    puts "ベンチマーク完了！"
  end
end