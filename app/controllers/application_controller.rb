class ApplicationController < ActionController::Base
  protect_from_forgery
  skip_before_filter  :verify_authenticity_token, :if => Proc.new { |c| 
    c.request.format == 'application/json' }
    
  before_filter :authenticate_user!, :except => [:create, :index]    
  layout :layout_by_resource
  #request.format = :json if params[:format].blank? && :subdomain?'api'
  
  def layout_by_resource
    if user_signed_in?
      'application'
     elsif request.subdomain == "api"
      "api/index"
     else
      "public/index"
       
    end
  end
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || events_path
  end
  def server_ip
    location = request.env["SERVER_ADDR"]
    render :text => "This server hosted at #{location}"
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
   protected

  
end
