class ApplicationController < ActionController::Base
  protect_from_forgery

  def default_url_options(options={})
  	logger.debug "default_url_options is passed options: #{options.inspect}\n"
  	{ :locale => I18n.locale }
	end

	before_filter :set_locale

	def set_locale
    if session[:user_id]  
      @user = Couch.find_by_id session[:user_id]
      I18n.locale = @user ? @user.locale || I18n.default_locale : I18n.default_locale
    else
      I18n.locale = I18n.default_locale     
    end
	end
end
