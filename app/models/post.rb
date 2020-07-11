class Post < ApplicationRecord
	belongs_to :user
	belongs_to :category
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	# validates :title, presence: true, length: {maximum: 200}
	# validates :subject, presence: true, length: {maximum: 50}
	# validates :body, presence: true
end
