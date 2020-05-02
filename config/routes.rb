Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/", to: "welcome#index"

  get "/merchants", to: "merchants#index"
  get "/merchants/new", to: "merchants#new"
  get "/merchants/:id", to: "merchants#show"
  post "/merchants", to: "merchants#create"
  get "/merchants/:id/edit", to: "merchants#edit"
  patch "/merchants/:id", to: "merchants#update"
  delete "/merchants/:id", to: "merchants#destroy"

  #resources :merchants

  get "/merchants/:merchant_id/items", to: "items#index"

#  resources :merchants do
#    resources :items, only: [:index]
#  end

get "/items", to: "items#index"
get "/items/:id", to: "items#show"
get "/items/:id/edit", to: "items#edit"
patch "/items/:id", to: "items#update"

#  resources :items, only: [:index, :show, :edit, :update]

get  "/items/:item_id/reviews/new", to: "reviews#new"
post "/items/:item_id/reviews", to: "reviews#create"

#  resources :items do
#    resources :reviews, only: [:new, :create]
#  end

get "/reviews/:id/edit", to: "reviews#edit"
patch "/reviews/:id", to: "reviews#update"
delete "/reviews/:id", to: "reviews#destroy"


#  resources :reviews, only: [:edit, :update, :destroy]

#NOTE: I wasn't sure how to switch this to resource routing with the session controller
  #login/logout
  delete "/logout", to: "sessions#destroy"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"

#NOTE: The cart is a PORO, hence the additional controller actions.
  #cart
  post "/cart/:item_id", to: "cart#add_item"
  patch "/cart/:item_id", to: "cart#plus_minus"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#destroy"
  delete "/cart/:item_id", to: "cart#remove_item"
  patch "/cart/:item_id/:increment_decrement", to: "cart#increment_decrement"

  #orders

#  resources :orders

  get "/orders", to: "orders#index"
  get "/orders/new", to: "orders#new"
  get "/orders/:id", to: "orders#show"
  post "/orders", to: "orders#create"
  get "/orders/:id/edit", to: "orders#edit"
  patch "/orders/:id", to: "orders#update"
  delete "/orders/:id", to: "orders#destroy"

  get "/register", to: "users#new"

  resources :users, only: [:create]
#  post "/users", to: "users#create"

  #admin
  namespace :admin do
    get '/', to: "dashboard#index"
    resources :users, only: [:index, :show]
#    get '/users', to: "users#index"
#    get '/users/:id', to: "users#show"
    resources :merchants, only: [:index, :update, :show]
#    get '/merchants', to: "merchants#index"
#    patch '/merchants/:id', to: "merchants#update"
#    get "/merchants/:id", to: "merchants#show"
  end

  #merchant-employee
  namespace :merchant do
    get "/", to: "dashboard#show"
    #  resources :items do
    #    resources :reviews, only: [:new, :create]
    #  end
    resources :items, only: [:index, :destroy, :edit, :new]
#    get "/items", to: "items#index"
    patch "/items/:id", to: "item_status#update"
    put "/items/:id", to: "items#update"
#    delete "/items/:id", to: "items#destroy"
#    get "/items/:id/edit", to: "items#edit"
#    get "/items/new", to: "items#new"
    post "/:merchant_id/items", to: "items#create"
    resources :orders, only: [:show]

#    get "/orders/:order_id", to: "orders#show"
    patch "/orders/:order_id/:item_id", to: "orders#update"

    resources :discounts, only: [:index, :show, :edit, :update, :destroy]

    resources :items do
      resources :discounts, only: [:new, :create]
    end
#    get "/discounts", to: "discounts#index"
#    get "/items/discounts", to: "discounts#index"
#    get "/discounts/:item_id/new", to: "discounts#new"
#    get "/items/discounts/:discount_id", to: "discounts#show"
#    get "items/discounts/:discount_id/edit", to: "discounts#edit"
#    put "/items/discounts/:discount_id", to: "discounts#update"
#    post "/items/discounts/:item_id", to: "discounts#create"
#    delete "/items/discounts/:discount_id", to: "discounts#destroy"
  end

  namespace :profile do
    get "/", to: "profile#show"
    get "/password/edit", to: "passwords#edit"
    patch "/password/edit", to: "passwords#update"
    get "/:id/edit", to: "profile#edit"
    patch "/:id", to: "profile#update"

    resources :orders, only: [:index, :show]
#    get "/orders", to: "orders#index"
#    get "/orders/:order_id", to: "orders#show"
  end

end
