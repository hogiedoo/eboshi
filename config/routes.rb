Eboshi::Application.routes.draw do |map|
  root :to => "clients#index"

  map.resources :clients, :shallow => true do |client|
    client.resources :invoices,
      :shallow => true,
      :name_prefix => nil do |invoice|
        invoice.resources :payments,
          :shallow => true,
          :name_prefix => nil
    end

    client.resources :line_items,
      :shallow => true,
      :only => [:update],
      :name_prefix => nil
    client.resources :works,
      :shallow => true,
      :except => [:index, :show],
      :collection => [:merge],
      :member => { :convert => :post },
      :name_prefix => nil
    client.resources :adjustments,
      :shallow => true,
      :except => [:index, :show],
      :name_prefix => nil

    client.resources :assignments,
      :shallow => true,
      :only => [:new, :create, :destroy],
      :name_prefix => nil
  end
  
  map.clock_in '/clients/:client_id/clock_in.:format', :controller => 'works', :action => 'clock_in'
  map.clock_out '/clients/:client_id/works/:id/clock_out.:format', :controller => 'works', :action => 'clock_out'

  map.calendar '/calendar/:year/:month', :controller => 'calendar', :action => 'index'

  map.resources :users
  map.resource :account, :controller => "users"
  map.resource :user_session

  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'

  map.resource :install, :only => [:new, :create]

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

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
