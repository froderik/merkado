require 'couch_potato'

class HeartController < ApplicationController
  def landing
  end

  def sign_in
    user = CouchPotato.database.first User.by_email( :key => params[:email] )
    if user
      session[:user_id] = user.id
      redirect_to '/order_books'
    else
      redirect_to :root, :notice => 'Invalid user'
    end
  end

  def sign_out
    reset_session
    redirect_to :root, :notice => "You have been signed out"
  end
end
