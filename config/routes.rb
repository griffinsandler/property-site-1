Rails.application.routes.draw do
  resources :properties
  root :to => redirect('/home')
  
  # Sessions routes #
  get '/home' => 'sessions#home'
  post '/search' => 'sessions#search'
  get '/join/:id/:pid' => 'sessions#sendreq'
  get '/create' => 'sessions#create'
  get '/signin' => 'sessions#signin'
  post '/signin/:op' => 'sessions#new'
  post '/create/manager/:op' => 'sessions#createManager'
  post '/create/tenant/:op' => 'sessions#createTenant'
  get  'auth/:provider/callback' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  get  'auth/failure' => 'sessions#failure'
  get  'auth/facebook', :as => 'login'
  
  # Managers routes #
  get '/request/:op/:id' => 'managers#respond'
  get '/managers/show' => 'managers#show'
  get '/managers/edit' => 'managers#edit'
  patch '/managers/edit' => 'managers#update'
  
  # Tenants routes #
  get '/tenants/show' => 'tenants#show'
  get '/tenants' => 'tenants#index'
  get '/tenants/new' => 'tenants#new'
  post '/tenants/new' => 'tenants#create'
  get '/tenants/edit' => 'tenants#edit'
  patch '/tenants/edit' => 'tenants#update'
  get '/tenants/pay' => 'tenants#pay'
  get '/tenants/pay/:id' => 'tenants#dummypay'
  get '/tenants/:op/:id' => 'tenants#service'
  
  # Properties routes #
  get '/properties' => 'properties#index'
  get '/properties/:id' => 'properties#show'
  get '/properties/new' => 'properties#new'
  post '/properties/new' => 'properties#create'
  get '/properties/:id/edit' => 'properties#edit'
  delete '/properties/:id/delete' => 'properties#destroy'
  
  # Services routes # 
  get '/services/new' => 'services#new'
  post '/services/new' => 'services#create'
  get '/services' => 'services#index'
  get '/services/:id' => 'services#show'
  post 'services/response/:id' => 'services#respond'
  
  # Added these for cucumber testing
    # sessions#create_guest makes a fake user for Cucumber testing with hard coded data 
    # so that session[:logged_in] is true
    get 'auth/guest', to: 'sessions#create_guest'
    # sessions#loggedin checks that the user is logged in and outputs session[:logged_in] to log folder
    # Since it is used by Cucumber, the output is put into the bottom of log/test.log
    get 'auth/loggedin', to: 'sessions#loggedin'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
