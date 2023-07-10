Rails.application.routes.draw do
  get 'bookmarks/new'
  get 'bookmarks/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "lists#index"
  # get "lists/new", to: "lists#new"
  # post "lists", to: "lists#create"
  # get "lists/:id", to: "lists#show", as: "list"
  resources :lists, only: [:new, :create, :show, :destroy] do
    member do
      resources :bookmarks, only: [:new, :create, :destroy]
      resources :reviews, only: [:new, :create]

    end
  end
end
