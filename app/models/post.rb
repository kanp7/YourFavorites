class Post < ApplicationRecord
	belongs_to :user
	belongs_to :category
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :notifications, dependent: :destroy

	validates :title, presence: true, length: {maximum: 200}
	validates :subject, presence: true, length: {maximum: 50}
	validates :body, presence: true

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def self.search(word)
		Post.where("title LIKE? OR author LIKE?" ,"%#{word}%", "%#{word}%")
	end

	def create_notification_by!(current_user)
		# すでにお気に入りされているか検索
		temp = Notification.where(["visiter_id = ? and visited_id = ? and post_id = ? and action = ?", current_user.id, user_id, id, 'favorite'])
		if temp.blank?
			notification = current_user.active_notifications.new(
				post_id: id,
				visited_id: user_id,
				action: "favorite"
				)
			# 自分の投稿に対するお気に入りの場合は、通知済みにする
			if notification.visiter_id == notification.visited_id
				notification.checked = true
			end
			notification.save if notification.valid?
		end
	end

	def create_notification_comment!(current_user, comment_id)
		# 自分以外にコメントしている人をすべて取得し、全員に通知を送る
		temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
		temp_ids.each do |temp_id|
			save_notification_comment!(current_user, comment_id, temp_id['user_id'])
		end
		# まだ誰もコメントしていない場合、投稿者に通知を送る
		save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
	end

	def save_notification_comment!(current_user, comment_id, visited_id)
		# コメントは複数回する場合があるため、1つの投稿に複数回通知する
		notification = current_user.active_notifications.new(
			post_id: id,
			comment_id: comment_id,
			visited_id: visited_id,
			action: 'comment'
			)
		# 自分の投稿に対するコメントの場合は通知済みとする
		if notification.visiter_id == notification.visited_id
			notification.checked = true
		end
		notification.save if notification.valid?
	end
end
