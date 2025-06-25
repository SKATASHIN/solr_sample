namespace :speed_results do
  desc "SQLとSolrの全文検索速度を比較する"
  task search: :environment do
    require 'benchmark'
    require_relative '../google_sheet'

    # 検索キーワード（ダミーデータに含まれる特別なキーワード）
    query = 'SuperUniqueKeyword2025'

    # データ件数を確認（SQLとSolrで一致しているかチェック）
    db_count = Article.count
    solr_count = Article.search { keywords('*') }.total

    puts "=== データ件数確認 ==="
    puts "データベース: #{db_count}件"
    puts "Solrインデックス: #{solr_count}件"
    puts ""

    # 各検索方式の実行時間を記録する配列
    sql_times = []
    solr_times = []

    5.times do
      # SQL LIKE検索の実行時間測定
      sql_time = Benchmark.measure {
        Article.where("body LIKE ?", "%#{query}%").to_a
      }.real
      sql_times << sql_time

      # Solr全文検索の実行時間測定
      solr_time = Benchmark.measure {
        Article.search { fulltext(query) { fields(:body) } }.results
      }.real
      solr_times << solr_time
    end

    puts "sql_times: #{sql_times}"
    puts "solr_times: #{solr_times}"

    # 平均速度を計算
    average_sql_time = (sql_times.sum / sql_times.size).round(6)
    average_solr_time = (solr_times.sum / solr_times.size).round(6)


    puts "average_sql_time: #{average_sql_time} 秒"
    puts "average_solr_time: #{average_solr_time} 秒"

    winner_type, speed_ratio = if average_sql_time < average_solr_time
                                  ['sql', (average_solr_time / average_sql_time).round(2)]
                                else
                                  ['solr', (average_sql_time / average_solr_time).round(2)]
                                end

    puts "winner_type: #{winner_type}"
    puts "speed_ratio: #{speed_ratio}"

    begin
      rows = [
        ['ベンチマーク結果'],
        [ '種別', 'データ件数', '実行回数', '平均速度'],
        [
          'SQL',
          "#{db_count} 件",
          "#{sql_times.size} 回",
          "#{average_sql_time} 秒",
        ],
        [
          'Solr',
          "#{solr_count} 件",
          "#{solr_times.size} 回",
          "#{average_solr_time} 秒",
        ],
        [],
        ['検証結果'],
        ['実行時間が短いのは？', winner_type],
        ['速度比', "#{speed_ratio} 倍"]
      ]

      google_sheet = GoogleSheet.new
      google_sheet.clear_worksheet
      google_sheet.append_row(rows)
    rescue => e
      puts "スプレットシート編集中にエラーが発生しました: #{e.message}"
    end
  end
end