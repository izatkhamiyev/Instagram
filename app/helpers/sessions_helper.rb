module SessionsHelper
	
	def sign_in (user)	
		session[:user_id] = user.id
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user
		if session[:user_id]
			@current_user ||= User.find(session[:user_id])
		elsif cookies.signed[:user_id]
			user = User.find_by(id: cookies.signed[:user_id])
			if user && user.authenticated?(cookies[:remember_token])
    			sign_in user
   				@current_user = user
  			end
		end
	end

	def sign_out
		forget current_user
		session[:user_id] = nil
		@current_user = nil
	end

	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
	    cookies.permanent[:remember_token] = user.remember_token		
	end

	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end
	def current_user?(user)
    	user == current_user
 	end

end
