class SettingsController < ApplicationController
  before_filter :authenticate_user!
   before_filter :current_user, :only => [:edit, :update]
  def account
    @user = current_user
  end

  def password
    @user = current_user
  end

  def update_password
    @user = current_user
    # raise params.inspect
    if @user.update_with_password(params[:user])
      sign_in(@user, :bypass => true)
      redirect_to root_path, :notice => "Your Password has been updated!"
    else
      render :password ,:locals => { :resource => @user, :resource_name => "user" }
    end
  end

  def deactivate_me
    @user = current_user
    # raise params.inspect
    if @user.update_attributes(params[:user])
      redirect_to root_path, :notice => "Your Account has been deactivated!"
    else
      render :password ,:locals => { :resource => @user, :resource_name => "user" }
    end
    
  end
  def notifications
    @user = User.find_by_username(current_user.username)
  end

  def profile
    @user = current_user
  end

  def avatar_upload
    @user = current_user

     respond_to do |format|
       if @user.update_attributes(params[:user])
         format.html { redirect_to "/settings/profile", notice: 'User was successfully updated.' }
       else
         format.html { render action: "profile" }
       end
     end
  end


end
