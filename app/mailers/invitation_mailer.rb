class InvitationMailer < ActionMailer::Base
  default from: "invitation@merkado.com"
 
  def invitation_email(invite)
    @invite = invite
    @url  = "www.example.com"
    mail(:to => invite.email, :subject => "Welcome to My Order Book")
  end

end
