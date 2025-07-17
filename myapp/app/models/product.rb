class Product < ApplicationRecord
  # searchable メソッドで全文検索対象を指定
  searchable do
    text :name, :description

    string :model_type do
      'Product'
    end
  end
end
