class Post < ApplicationRecord
	belongs_to :user
	belongs_to :category
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	validates :title, presence: true, length: {maximum: 200}
	validates :subject, presence: true, length: {maximum: 50}
	validates :body, presence: true

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def self.search(word)
		Post.where("title LIKE? OR author LIKE?" ,"%#{word}%", "%#{word}%")
	end

end
