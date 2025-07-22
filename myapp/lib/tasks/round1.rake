namespace :round1 do
  desc "SQLとSolrの全文検索速度を比較"
  task speed: :environment do
    require 'benchmark'
    puts "================SQLとSolrの全文検索速度開始====================="

    # 検索キーワード（ダミーデータに含まれる特別なキーワード）
    query = 'SuperUniqueKeyword2025'

    # データ収集
    db_count, solr_count = get_data_count
    sql_times, solr_times = run_benchmarks(query)

    # 計算結果
    avg_sql, avg_solr = calculate_averages(sql_times, solr_times)
    winner, ratio = get_winner_and_ratio(avg_sql, avg_solr)
    puts "================SQLとSolrの全文検索速度終了====================="
  end
end

private

  def get_data_count
    db_count = RoundOne.count
    solr_count = RoundOne.search { keywords('*') }.total

    puts "DBレコード数: #{db_count}件"
    puts "Solrインデックス数: #{solr_count}件"

    [db_count, solr_count]
  end

  def run_benchmarks(query)
    sql_times = []
    solr_times = []

    # 5回計測して平均時間を取得
    5.times do
      # SQL LIKE検索の実行時間測定
      sql_time = Benchmark.measure {
        RoundOne.where("body LIKE ?", "%#{query}%").to_a
      }.real
      sql_times << sql_time

      # Solr全文検索の実行時間測定
      solr_time = Benchmark.measure {
        RoundOne.search { fulltext(query) { fields(:body) } }.results
      }.real
      solr_times << solr_time
    end

    puts "SQL実行時間: #{sql_times}"
    puts "Solr実行時間: #{solr_times}"

    [sql_times, solr_times]
  end

  def calculate_averages(sql_times, solr_times)
    avg_sql = (sql_times.sum / sql_times.size).round(4)
    avg_solr = (solr_times.sum / solr_times.size).round(4)

    puts "SQL平均実行時間: #{avg_sql} 秒"
    puts "Solr平均実行時間: #{avg_solr} 秒"

    [avg_sql, avg_solr]
  end

  def get_winner_and_ratio(avg_sql, avg_solr)
    winner, ratio = if avg_sql < avg_solr
                      ['sql', (avg_solr / avg_sql).round(2)]
                    else
                      ['solr', (avg_sql / avg_solr).round(2)]
                    end

    puts "勝者: #{winner}"
    puts "速度比: #{ratio}"

    [winner, ratio]
  end

