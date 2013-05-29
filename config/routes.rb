Kripa::Application.routes.draw do

  get "sessions/new"

  get "users/new"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"

  post "welcome/index"
  
  ['parts', 'models', 'prices', 'makes', 'customers', 'part_prices'].each do |entity|
    get entity + '/index'
    get entity + '/ajaxAutoCompleteValue'
    get entity + '/ajaxIndex'
    get entity + '/ajaxSearch'
    get entity + '/ajaxNew'
    get entity + '/ajaxEdit'
    get entity + '/ajaxUpdate'
    get entity + '/ajaxCreate'
    get entity + '/ajaxDelete'
    get entity + '/ajaxSingleDisplayRow'
  end
  
  resources :customers
  resources :sessions
  resources :users

  root :to => "part_prices#index"
end
