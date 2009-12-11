ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'clients', :action => 'index'

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

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
