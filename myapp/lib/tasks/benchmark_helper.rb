module BenchmarkHelper
  def self.print_all_counts(model)
    puts model.name

    db_count = model.count
    solr_count = model.search { keywords('*') }.total
    puts "DBレコード数: #{db_count}件"
    puts "Solrインデックス数: #{solr_count}件"
  end

  def self.print_results(sql_times:, solr_times:, sql_results:, solr_results:)
    sql_avg = (sql_times.sum / sql_times.size).round(4)
    solr_avg = (solr_times.sum / solr_times.size).round(4)
    speed_ratio = (sql_avg / solr_avg).round(2)
    winner = speed_ratio > 1 ? "Solr" : "SQL"

    puts "SQL実行結果件数: #{sql_results.size}件"
    puts "Solr実行結果件数: #{solr_results.size}件"
    puts "SQL平均実行時間: #{sql_avg} 秒"
    puts "Solr平均実行時間: #{solr_avg} 秒"
    puts "勝者: #{winner}"
    puts "速度比: #{speed_ratio}倍"
  end
end