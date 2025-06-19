## 🔖 開発用メモ（Solr関連）

```bash
# Railsが動いているコンテナに入る（例: webサーバ）
docker-compose exec web bash

# データベースを初期化（全テーブル削除＋作成）
bundle exec rails db:reset

# ダミーデータを再投入
bundle exec rails db:seed

# Solr にインデックスを再構築（検索対象にする）
bundle exec rake sunspot:reindex

# 検索ベンチマーク実行（SQL vs Solr）
bundle exec rake speed_results:search
