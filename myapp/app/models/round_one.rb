class RoundOne < ApplicationRecord
  # searchable メソッドで全文検索対象を指定
  searchable do
    text :body, as: :body
  end
end
