class Product < ApplicationRecord
  # searchable メソッドで全文検索対象を指定
  searchable do
    text :name, as: :name
  end
end
