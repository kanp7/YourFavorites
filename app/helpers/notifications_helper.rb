module NotificationsHelper

  def notification_form(notification)

    your_post = link_to 'あなたの投稿', notification.post, style:"font-weight: bold;"

    case notification.action
      when "follow" then
        "あなたをフォローしました".html_safe
      when "favorite" then
        "#{your_post}にいいね！しました".html_safe
      when "comment" then
        "#{your_post}にコメントしました".html_safe
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

end
