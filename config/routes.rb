Rails.application.routes.draw do

  root :to => "home#index"
  resources :notes
  get "login", :to => 'home#login'
  post "login_create", :to => 'home#login_create'
  get 'logout', :to => 'home#logout'
  get 'register', :to => 'users#new'
  resources :users
  get "topics/node_:id" => "topics#node", :as => :node_topics
  get "topics/recent" => "topics#recent", :as => :recent_topics
  get 'setting', :to => 'users#setting', :as => 'setting'
  get 'setting/password', :to => 'users#password', :as => 'password'
  resources :topics do
    member do
      post :reply
    end
  end

  resources :photos do
    collection do
      get :tiny_new
    end
  end


  namespace :cpanel do
    root :to => "home#index"
    resources :topics
    resources :sections
    resources :replies
    resources :nodes
    resources :users
    resources :photos
  end
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
