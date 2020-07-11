class Category < ApplicationRecord
	has_many :post
	has_many :genre_relation
end
