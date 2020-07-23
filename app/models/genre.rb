class Genre < ApplicationRecord
	has_many :genre_relations
	has_many :categories, through: :genre_relations
end
