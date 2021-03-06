class Notifications::Email
  @queue = "email_notification_#{Rails.env}"

  def self.perform(notification_id)
    person_notifications = Notification.find(notification_id).person_notifications

    unless person_notifications.blank?
      person_notifications.each do |person_notification|
        person_notification.alerted_with << { source: 'email', date: Time.now }
        person_notification.save

        PersonNotificationMailer.alerting(person_notification.id).deliver
      end
    end


  end
end