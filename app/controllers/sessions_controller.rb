class SessionsController < ApplicationController

  def new
    redirect_to "/auth/twitter"
  end


  def create
    auth = request.env["omniauth.auth"]
    user = User.where(:provider => auth['provider'], 
                      :uid => auth['uid']).first || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    if !user.email
      redirect_to edit_user_path(user), :alert => "Please enter your email address."
    else
      redirect_to root_url, :notice => 'Signed in!'
    end
  rescue Exception => e
    # Just spit out the error message and a backtrace.
    render :text => "<html><body><pre>" + e.to_s + "</pre><hr /><pre>" + e.backtrace.join("\n") + "</pre></body></html>"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
