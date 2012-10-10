class HeartController < ApplicationController
  def landing
  end

  def sign_in
    redirect_to :root, :notice => 'Invalid user'
  end
end
