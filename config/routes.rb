Rails.application.routes.draw do
  resources :properties
  root :to => redirect('/home')
  get '/home' => 'sessions#home'
  get '/create' => 'sessions#create'
  get '/signin' => 'sessions#signin'
  post '/signin/:op' => 'sessions#new'
  post '/create/manager/:op' => 'sessions#createManager'
  post '/create/tenant/:op' => 'sessions#createTenant'
  get '/managers/show' => 'managers#show'
  get '/tenants/show' => 'tenants#show'
  get '/tenants' => 'tenants#index'
  get '/tenants/new' => 'tenants#new'
  post '/tenants/new' => 'tenants#create'
  get '/properties' => 'properties#index'
  get '/properties/:id' => 'properties#show'
  get '/properties/new' => 'properties#new'
  post '/properties/new' => 'properties#create'
  get '/properties/:id/edit' => 'properties#edit'
  delete '/properties/:id/delete' => 'properties#destroy'
  resources :landlords
  get '/landlords'=> 'landlords#index'
  get '/landlords/:id'=>'landlords#show'
  get '/landlords/new' => 'landlords#new'
  post '/landlords/new' => 'landlords#create'
  get  'auth/:provider/callback' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  get  'auth/failure' => 'sessions#failure'
  get  'auth/facebook', :as => 'login'
  get '/tenants/:id/pay' => 'tenants#pay'
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
