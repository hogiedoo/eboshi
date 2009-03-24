class ApplicationController < ActionController::Base
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user
	
  helper :all # include all helpers, all the time

  self.allow_forgery_protection = false
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '777e12608199867e6528eb1a3556d20d'

  before_filter :activate_authlogic
  before_filter :require_user

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to login_path
        return false
      end
    end

    def require_no_user
      if current_user
        flash[:notice] = "You must be logged out to access this page"
        redirect_to '/'
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
    def rescue_action_in_public(exception)
      respond_to do |want|
        want.html {
          super(exception)
        }
        want.js {
          render :update do |page|
            page.alert "We're sorry, but something went wrong.\nWe've been notified about this issue and we'll take a look at it shortly.\n\nPlease check that any update you tried has not been successful before trying it again."
          end
        }
      end
    end

    def rescue_action_locally(exception)
      respond_to do |want|
        want.html {
          super(exception)
        }
        want.js {
          render :update do |page|
            page.alert "Oops! I made a mistake\n#{exception.class}: #{exception.message}\nCheck the logs for more detail."
          end
        }
      end
    end

end
