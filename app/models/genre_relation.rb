class GenreRelation < ApplicationRecord
	belongs_to :categories
	belongs_to :genres
end
