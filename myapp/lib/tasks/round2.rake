namespace :round2 do
  desc "SQLとSolrの複数フィールド検索（title+body）速度比較"
  task speed: :environment do
    require 'benchmark'
    puts "============SQLとSolrの複数フィールド検索（title+body）速度比較_開始============="

    BenchmarkHelper.print_all_counts(RoundTwo)

    n = 5
    sql_times, solr_times = [], []
    sql_results, solr_results = nil, nil

    query = 'SuperUniqueKeyword2025'

    n.times do
      # SQL
      sql_times << Benchmark.measure {
        sql_results = RoundTwo.where('title LIKE ? OR body LIKE ?', "%#{query}%", "%#{query}%").to_a
      }.real

      # Solr
      solr_times << Benchmark.measure {
        solr_results = RoundTwo.search {
          fulltext(query) { fields(:title, :body) }
        }.results.to_a
      }.real
    end

    BenchmarkHelper.print_results(
      sql_times: sql_times,
      solr_times: solr_times,
      sql_results: sql_results,
      solr_results: solr_results
    )

    puts "============SQLとSolrの複数フィールド検索（title+body）速度比較_終了============="
  end
end





