Kripa::Application.routes.draw do

  resources :sessions
  
  resources :users
  
  resources :part_prices

  root :to => "application#index"
end

#REFACTORED