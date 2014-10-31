Rails.application.routes.draw do


  mount Rich::Engine => '/rich', :as => 'rich'
  # admin routes
  namespace :admin do
    #session
    resources :sessions, only: [:new, :create, :destroy]
    match '/signin', to: 'sessions#new', via: 'get'
    match '/signout', to: 'sessions#destroy', via: 'delete'

    #manager
    resources :manager

    #dashboard
    root 'dashboard#index'

    #pages
    resources :pages do
      collection do
        post :rebuild
        get '/all' => 'pages#all'
        get '/find/:id' => 'pages#find'
      end
    end

    #products
    resources :products
    get '/products/find/:id' => 'products#find'
    post '/products/:product_id/property/:property_id/value/:value_id' => 'products#set_property_value'
    post '/products/:product_id/brand/:brand_id' => 'products#set_brand'
    post '/products/:product_id/category/:category_id' => 'products#set_category'

    #sub_products
    #/products/12/sub_product/new
    get '/products/:product_id/sub_product/new' => 'products#sub_product_new'
    put '/sub_product/:sub_product_id' => 'products#sub_product_update'
    get '/products/:product_id/sub_product/:sub_product_id/destroy' => 'products#sub_product_destroy'
    
    #categories
    resources :categories do
      collection do
        post :rebuild
      end
    end

    resources :brands do
      collection do
        post :rebuild
      end
    end

    resources :news
    
    resources :properties do
      post :values
      delete '/values/:id' => 'properties#delete_value'
    end

    resources :feedbacks

    get '/categories/find/:id' => 'categories#find'
    get '/brands/find/:id' => 'brands#find'

    #photos uploader
    get '/product/photos/:product_id' => 'photos#find'
    post '/product/photos/upload' => 'photos#upload'
    
    get '/sub_product/photos/:sub_product_id' => 'photos#find_sub_product'
    post '/sub_product/photos/upload' => 'photos#upload_sub_product'
    
    get '/category/photos/:category_id' => 'photos#find_category'
    post '/category/photos/upload' => 'photos#upload_category'

    get '/brand/photos/:brand_id' => 'photos#find_brand'
    post '/brand/photos/upload' => 'photos#upload_brand'

    get '/gallery/photos/:gallery_id' => 'photos#find_gallery'
    post '/gallery/photos/upload' => 'photos#upload_gallery'

    delete '/photos/:id' => 'photos#destroy'
    put '/photos/edit/:id' => 'photos#update'

    resources :galleries do

    end

  end


  post '/feedback/create' => 'feedbacks#create'

  root 'pages#index'
  get '/root' => 'pages#index'

  get '/pages/carousel' => 'pages#carousel'

  #filters
  get '/product/filters/' => 'products#filters'


  get '/catalog/:category_id/product/:product_id' => 'products#product'
  get '/catalog/*section/:category_id/product/:product_id' => 'products#product'
  get '/catalog/*section/*section/:category_id/product/:product_id' => 'products#product'

  get '/catalog' => 'products#catalog'
  get '/catalog/:id' => 'products#category'
  get '/catalog/*section/:id' => 'products#category'
  get '/catalog/*section/*section/:id' => 'products#category'

  get '/brands' => 'products#brands', :as => 'brands'
  get '/brands/:id' => 'products#brand'

  get '/news' => 'news#index'
  get '/news/:id' => 'news#show', :as => 'news_show'
  
  get ':id' => 'pages#show'


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
