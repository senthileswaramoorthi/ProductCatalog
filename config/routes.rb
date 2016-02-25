Rails.application.routes.draw do
  get 'products/home'
 
  get 'products/login'

  get 'products/login_process'

  get 'products/new_account'

  get 'products/new_account_process'

  get 'products/browser'

  get 'products/help_browser'

  get 'products/browser_process'

  get 'products/result'

  get 'products/result_process'

  get 'products/aboutus'

  get 'products/description'

  get 'products/details'

  get 'products/logout'

  post 'products/result'

  put 'products/result_process'

  patch 'products/result_process'

  post  'products/result_process'


  post 'products/login'

  post 'products/login_process'
 
  post 'products/browser'

  post 'products/browser_process'

  post 'products/new_account_process'

  post 'products/description'

  post 'products/details'

  post 'products/aboutus'

  post 'products/logout'
  
  post 'products/home'

  get 'products/show'
resources :products do
get 'dest2'

  get 'manu'
  get 'manu_index'
 end


  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'products#home'

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
