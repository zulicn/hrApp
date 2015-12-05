class EestecMailer < MandrillMailer::TemplateMailer
  default from: "hr@eestec-sa.ba"
  default from_name: "EESTEC HR"

  def user_acceptance(user_id)
    @user = User.find(user_id)
    mandrill_mail(
      template: 'Dobrodoslica',
      to: @user.email, 
      subject: "Dobrodoslica",
      vars: {
        'USER_NAME' => @user.firstname,
      }
    )
  end

  def new_event(event_id, see_event_url)
    @event = Event.find(event_id)
    recipients = User.all.map(&:email)
    mandrill_mail(
      template: 'Event',
      to: recipients, 
      subject: "Kreiran je novi event - Prijavi se",
      vars: {
        'EVENT_NAME' => @event.name,
        'EVENT_DESCRIPTION' => @event.description,
        'EVENT_URL' => see_event_url
      }
    )
  end

end