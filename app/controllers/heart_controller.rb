require 'couch_potato'

class HeartController < ApplicationController
  def landing
    if session[:user_id]
      redirect_to '/order_books'
    end
  end

  def sign_in
    user = User.find_by_email params[:auth_key]
    if user
      session[:user_id] = user.id
      redirect_to '/order_books'
    else
      redirect_to :root, :notice => 'Invalid user'
    end
  end

  def sign_out
    reset_session
    redirect_to :root, :notice => 'You have been signed out'
  end

  def auth_failure
    reset_session
    redirect_to :root, :notice => 'Invalid user'
  end
end
