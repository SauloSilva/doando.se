# encoding: utf-8
class PersonNotificationMailer < ActionMailer::Base
  layout 'mailer'
  helper :mailers
  include MandrillMailer

  default from: 'suporte@doando.se'

  def alerting(person_notification_id)
    @person_notification = PersonNotification.find(person_notification_id)
    @notification = @person_notification.notification
    mail subject: "Foi criada uma nova notificação na qual precisam de você #{@notification.title}", to: @person_notification.person.user.email
  end

  def confirmed(person_notification_id)
    @person_notification = PersonNotification.find(person_notification_id)
    mail subject: "Obrigado por participar #{@person_notification.notification.title}", to: @person_notification.person.user.email
  end

  def confirmation(person_notification_id)
    @person_notification = PersonNotification.find(person_notification_id)
    mail subject: "+ 1 voluntario se cadastrou na #{@person_notification.notification.title}", to: @person_notification.notification.company.user.email
  end

  def resending(person_notification_id)
    @person_notification = PersonNotification.find(person_notification_id)
    mail subject: "Pense com carinho nessa notificacao: #{@person_notification.notification.title}", to: @person_notification.person.contact.email
  end

  def undo_confirmation(person_notification_id)
    @person_notification = PersonNotification.find(person_notification_id)
    mail subject: "Cancelamento de um participante da notificacao: #{@person_notification.notification.title}", to: @person_notification.person.contact.email
  end
end