class Category < ApplicationRecord
	has_many :post
	has_many :genre_relations
	has_many :genres, through: :genre_relations
end
