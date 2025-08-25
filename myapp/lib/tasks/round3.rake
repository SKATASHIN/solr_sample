namespace :round3 do
  desc "SQLとSolrのcreated_at降順＋最新10件取得の処理速度比較"
  task speed: :environment do
    require 'benchmark'
    puts "============SQLとSolrのcreated_at降順＋最新25件取得の処理速度比較_開始============="

    BenchmarkHelper.print_all_counts(RoundThree)

    row = 10
    sql_times, solr_times = [], []
    sql_results, solr_results = nil, nil

      # SQL
      sql_time = Benchmark.realtime do
        sql_results = RoundThree
          .order(created_at: :desc)
          .limit(row)
          .pluck(:id)
      end

      # Solr
      solr_time = Benchmark.realtime do
        search = RoundThree.search do
          adjust_solr_params do |p|
            p[:q]    = '*:*'
            p[:fl]   = 'id'
            p[:rows] = row
            p[:sort] = 'created_at desc'
          end
        end

        solr_results = search.hits.map { |h| h.primary_key.to_i }
      end

      puts "SQL 実行時間: #{sql_time}s"
      puts "SQL 結果件数: #{sql_results.size}"
      puts "Solr 実行時間: #{solr_time}s"
      puts "Solr 結果件数: #{solr_results.size}"

    puts "============SQLとSolrのcreated_at降順＋最新25件取得の処理速度比較_終了============="
  end
end





