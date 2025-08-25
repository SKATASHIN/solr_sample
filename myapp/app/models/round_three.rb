class RoundThree < ApplicationRecord
  searchable do
    text :body
    time :created_at, as: :created_at
  end
end
