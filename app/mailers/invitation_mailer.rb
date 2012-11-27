class InvitationMailer < ActionMailer::Base
  default from: "invitation@mimi.com"
 
  def invitation_email(invite)
    @invite = invite
    @url  = "www.baam.com"
    mail(:to => @invite.email, :subject => "Welcome to My Order Book with id #{@invite.order_book_id}")
  end

end
