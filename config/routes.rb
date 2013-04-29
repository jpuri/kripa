Kripa::Application.routes.draw do

  get "sessions/new"

  get "users/new"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"

  post "welcome/index"
  get 'parts/ajaxIndex'
  get 'parts/ajaxNew'
  get 'parts/ajaxEdit'
  get 'parts/ajaxUpdate'
  get 'parts/ajaxCreate'
  get 'parts/ajaxDelete'
  get 'bills/getPartDetails'
  get 'bills/calculatePartDetails'
  get 'bills/getWeigthPrice'
  get 'models/addModelPart'
  get 'models/saveModelPart'
  get 'models/search'
  get 'makes/addModel'
  get 'makes/saveModel'

  resources :bill_parts
  resources :customers
  resources :part_prices
  resources :bills
  resources :parts
  resources :currencies
  resources :models
  resources :sessions
  resources :users
  resources :makes

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  root :to => "partPrices#index"
end
