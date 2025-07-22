class RoundTwo < ApplicationRecord
  searchable do
    text :title
    text :body
  end
end
