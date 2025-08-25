require_relative './benchmark_helper'

namespace :round1 do
  desc "SQLとSolrの全文検索速度比較"
  task speed: :environment do
    require 'benchmark'
    puts "============SQLとSolrの全文検索速度比較_開始============="

    BenchmarkHelper.print_all_counts(RoundOne)

    row = 10
    query = 'SuperUniqueKeyword2025'
    sql_times, solr_times = [], []
    sql_results, solr_results = [], []

    # --- SQL: FULLTEXT（MATCH AGAINST） ---
    sql_time = Benchmark.realtime do
      sql_results = RoundOne
        .where("MATCH(body) AGAINST (?)", query)
        .limit(row)
        .pluck(:id)
    end

    # --- Solr: edismax + qf=body ---
    solr_time = Benchmark.realtime do
      search = RoundOne.search do
        adjust_solr_params do |p|
          p[:qf]      = 'body'
          p[:fl]      = 'id'
          p[:rows]    = row
        end
        fulltext(query) { fields(:body) }
      end

      solr_results = search.hits.map { |h| h.primary_key.to_i }
    end

    puts "SQL time : #{sql_time}s"
    puts "SQL results: #{sql_results.inspect}"
    puts "Solr time: #{solr_time}s"
    puts "Solr results: #{solr_results.inspect}"

    puts "============SQLとSolrの全文検索速度比較_終了============="
  end
end

