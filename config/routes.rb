Kripa::Application.routes.draw do

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  resources :sessions
  
  get "users/appUsers"
  resources :users
  
  # part price menus to be refactored and removed
  get "part_prices/index"
  get 'part_prices/ajaxSearch'
  get 'part_prices/ajaxNew'
  get 'part_prices/ajaxCreate'
  get 'part_prices/ajaxEdit'
  get 'part_prices/ajaxUpdate'
  get 'part_prices/ajaxDelete'
  get 'part_prices/ajaxSingleDisplayRow'
  get "part_prices/ajaxPartPriceMenu"
  get "part_prices/ajaxAutoCompleteParts"
  get "part_prices/ajaxAutoCompleteModels"
  get "part_prices/ajaxGetPartDescription"
  
  root :to => "welcome#index"
end