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
end