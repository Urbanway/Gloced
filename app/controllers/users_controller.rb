class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:create, :index]    
  before_filter :current_user, :only => [:edit, :update]

   def index
    @user = User.find_by_email(params[:email]) || not_found
    
   end

  # GET /users/1
  # GET /users/1.json
  def show
    if params[:id] != current_user.username
       @user = User.find_by_username(params[:id]) || not_found
     else
       @user = current_user || not_found
     end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
  def me
    @user = current_user
    
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find_by_username(params[:id]) || not_found
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find_by_username(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to :back, notice: 'User was successfully updated.' }
      else
        format.html { redirect_to :back }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find_by_username(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
  
#  def achievements
#    @user = User.find_by_username(params[:id])
#    @users = @user.following
#   end

  def events
     @user = User.find_by_username(params[:id])
     @events = @user.events
     respond_to do |format|
       format.html # show.html.erb
       format.json { render json: @events }
     end
  end
  def venues
     @user = User.find_by_username(params[:id])
     @venues = @user.venues
     respond_to do |format|
       format.html # show.html.erb
       format.json { render json: @venues }
     end
  end
  
  def following
      @user = User.find_by_username(params[:id])
      @users = @user.following
      render 'show_following'
      respond_to do |format|
        format.json { render json: @users }
      end
  end
  
  def followers
    @user = User.find_by_username(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

end
