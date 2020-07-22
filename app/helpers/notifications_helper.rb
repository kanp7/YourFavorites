module NotificationsHelper

  def notification_form(notification)
    case notification.action
      when "follow" then
        "あなたをフォローしました"
      when "favorite" then
        "あなたの投稿にいいね！しました"
      when "comment" then
        "あなたの投稿にコメントしました"
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

end
