module NotificationsHelper
  def participate_button(notification)
    if user_signed_in?
      participate = notification.will_participate(current_user.authenticable)
      if participate.present? && participate.non_canceled?
        link_to t('buttons.non_participate'), undo_confirm_notification_path(notification), class: 'button red'
      else
        link_to t('buttons.participate'), confirm_notification_path(notification), class: 'button red'
      end
    else
      link_to t('buttons.participate'), confirm_notification_path(notification), class: 'button red'
    end
  end

  def show_list(count, notification)
    if count.zero?
      count
    else
      link_to count, notification_list_user_path(notification)
    end
  end

  def situations
    [
      ['Urgente', 'urgent'],
      ['Moderado', 'moderate']
    ]
  end

  def parse_time(time)
    time.strftime("%m de %b %Y - %H:%M h")
  end
end