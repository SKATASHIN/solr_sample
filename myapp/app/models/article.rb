class Article < ApplicationRecord
  # searchable メソッドで全文検索対象を指定
  searchable do
    text :body, as: :text
  end
end
