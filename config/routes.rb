Rails.application.routes.draw do

  get 'images/delete'

  delete 'image/:id' => "images#delete_image"

  resources :posts

  resources :categories
  get 'admin/index'
  get 'admin/update'

  resources :adventures do
    # to add adventure to user's collection
    post '/add_adventure_to_current_user' => 'adventures#add_adventure'
    # sets route for google map on adventures show
    get 'map_location'
    # sets route for google map on adventures index
    get 'all_map_locations', on: :collection
  end

  get 'search/index'
  get '/profile/:username' => 'profile#show'
  get '/profile' => 'profile#show'
  get '/profile/:id/profile_map_locations' => 'profile#profile_map_locations'
  get '/feed' => 'profile#feed'

  get "admin" => "admin#index"
  put "admin/:id" => "admin#update"
  patch "admin/:id" => "admin#update"

  devise_for :users, controllers: {registrations: 'registrations', omniauth_callbacks: "omniauth_callbacks"}

  # adding routes for socialization gem - follow/unfollow users
  resources :users do
    post 'follow', to: 'socializations#follow'
    post 'unfollow', to: 'socializations#unfollow'
  end

  get 'about/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # You can have the root of your site routed with "root"
  root 'welcome#index'


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
