  Gloced::Application.routes.draw do
    constraints :subdomain => 'api', :format => :json do
      root :to => "pages#index"
      
      
      devise_for :users 
      devise_scope :user do
        get "/login" => "devise/sessions#new", :as => :new_user_session , :defaults => { :format => 'json' }
        post "/login" => "devise/sessions#create", :as => :new_user_session , :defaults => { :format => 'json' }

        match "/logout" => "devise/sessions#destroy", :as => :destroy_user_session 

        get "/register" => "devise/registrations#new", :as => :new_user_registration 

        get "/forget-password" => "devise/passwords#new", :as => :new_user_password 

        match "/confirm" => "devise/sessions#new", :as => :confirm 

      end
      
      match "tokens" => 'tokens#create', :via => :post
      match "tokens/:token" => 'tokens#destroy', :via => :delete
      #       
      # Routing for API requests
      get "/venues" => "venues#index", :as => :venues, :defaults => { :format => 'json' }
      get "/venues/:id" => "venues#show", :as => :venue, :defaults => { :format => 'json' }
      get "/events" => "events#list", :as => :events, :defaults => { :format => 'json' }
      get "/events/tag/:id" => "events#tag", :as => :taggedevents, :defaults => { :format => 'json' }
      get ':id/venues' => 'users#venues', :as => :uservenues, :defaults => { :format => 'json' }
       get ':id/events' => 'users#events', :as => :userevents, :defaults => { :format => 'json' }
       get ':id/following' => 'users#following', :as => :following, :defaults => { :format => 'json' }
       get ':id/followers' => 'users#followers', :as => :followers, :defaults => { :format => 'json' }
       get ':id' => 'users#show', :defaults => { :format => 'json' }
      # ...
    end
        root :to => "pages#index"
 #  constraints :subdomain => 'www', :format => :html do
       #static pages
       get "about" => 'pages#about'
       get "help" => 'pages#help'
       get "terms" => 'pages#terms'
       get "jobs" => 'pages#jobs'
       get "business" => 'pages#business'
       get "privacy" => 'pages#privacy'
       get "media" => 'pages#media'
       get "dev" => 'pages#dev'
       get "blog" => 'pages#blog'


       #settings 
       get "settings" => 'settings#profile'
       get "settings/account"
       get "settings/profile"

       get 'settings/password'
       put 'settings/password' => 'settings#update_password', :as => :update_password
       get "settings/notifications"

       put "settings/avatar_upload"
       put "settings/deactivate_me", :as => :deactivate_me

       #auth

       devise_for :users 
       devise_scope :user do

         get "/login" => "devise/sessions#new", :as => :new_user_session 

         match "/logout" => "devise/sessions#destroy", :as => :destroy_user_session 

         get "/register" => "devise/registrations#new", :as => :new_user_registration 

         get "/forget-password" => "devise/passwords#new", :as => :new_user_password 

         match "/confirm" => "devise/sessions#new", :as => :confirm 

       end
       resources :relationships, :only => [:create, :destroy]


       get "/venues/list" => "venues#list", :as => :venues_list

       resources :venues

       get "/events/tag/:id" => "events#tag", :as => :event_tags 
       get "/events/list" => "events#list"
       get "/events/mylist" => "events#mylist"
       get "/events/mygrid" => "events#mygrid"
       get "/events/all" => "events#index"
       
       resources :events

       resources :users, :only => [:show, :update]

      # get ':id/achievements' => 'users#achievements', :as => :userachievements
       get ':id/venues' => 'users#venues', :as => :uservenues
       get ':id/events' => 'users#events', :as => :userevents
       get ':id/following' => 'users#following', :as => :following
       get ':id/followers' => 'users#followers', :as => :followers
       match ':id' => 'users#show'
#    end


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  end
