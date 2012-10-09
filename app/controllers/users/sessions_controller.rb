# encoding: utf-8
class Users::SessionsController < ApplicationController
  def new
  end

  def create
    @authentication = Authentication.where(:provider => auth_hash.provider, :uid => auth_hash.uid).first

    case
      when @authentication then sign_in
      when current_user then add_new_authentication
      else sign_up
    end
  end

  def failure
    if current_user
      render "/sessions/callback_failure_popup_edit"
    else
      @user = User.new
      @user.authentications.build(:provider => 'foo')
      if params[:strategy] == 'identity'
        redirect_to users_new_session_path
      else
        render 'users/sessions/callback_failure'
      end
    end
  end

  def destroy
    logout
  end

  private
    def auth_hash
      request.env['omniauth.auth']
    end

    def sign_in
      login @authentication.user
      if @authentication.provider.eql?('identity')
        redirect_to root_path
      else
        render 'callback_popup'
      end
    end

    def sign_up
      @user = User.parse_omniauth(auth_hash)
      render 'callback_signup'
    end

    def add_new_authentication
      current_user.add_authentication(auth_hash)
      @user = {
         :state => :edit,
          :authentication => {
            :provider => auth_hash.provider,
            :uid => auth_hash.uid
          }
      }
      @authentications = User.social_networks(current_user)
      render '/sessions/callback_close_popup_edit'
    end
end