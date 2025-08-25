## 🔖 開発用メモ（Solr関連）

```bash
# Railsが動いているコンテナに入る（例: webサーバ）
docker-compose exec study_web bash 

# データベースを初期化（全テーブル削除＋作成）
bundle exec rails db:reset

# ダミーデータを再投入
bundle exec rails db:seed

# Solr にインデックスを再構築（検索対象にする）
SOLR_CORE=round1 bundle exec rake solr:reindex_round_one
SOLR_CORE=round2 bundle exec rake solr:reindex_round_two
SOLR_CORE=round3 bundle exec rake solr:reindex_round_three

# 検索ベンチマーク実行（SQL vs Solr）
SOLR_CORE=round1 bundle exec rake round1:speed
SOLR_CORE=round2 bundle exec rake round2:speed
SOLR_CORE=round3 bundle exec rake round3:speed
