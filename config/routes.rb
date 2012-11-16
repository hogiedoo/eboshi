Eboshi::Application.routes.draw do
  root :to => "clients#index"

  resources :clients do
    resources :invoices do
      resources :payments
    end

    resources :line_items, :only => [:update]
    resources :works, :except => [:index, :show] do
      post :merge ,  :on => :collection
      post :convert, :on => :member
    end
    resources :adjustments, :except => [:index, :show]
    resources :assignments, :only   => [:new, :create, :destroy]
  end
  
  match "/clients/:client_id/clock_in(.:format)"            => "works#clock_in",  :as => "clock_in"
  match "/clients/:client_id/works/:id/clock_out(.:format)" => "works#clock_out", :as => "clock_out"

  match "calendar/:year/:month" => "calendar#index", :as => "calendar"

  resources :users
  resource :account, :controller => "users"
  resource :user_session

  match "login"  => "user_sessions#new"
  match "logout" => "user_sessions#destroy"

  resource :install, :only => [:new, :create]

  match ":controller(/:action(/:id(.:format)))"

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
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
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
  #       get :recent, :on => :collection
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
