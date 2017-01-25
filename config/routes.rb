Rails.application.routes.draw do
  get 'info/kadai(.:format)'
  
  root to: 'static_pages#home'
  get    'signup', to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users do
    member do
      get 'followings'
      get 'followers'
    end
  end
  
  resources :microposts
  resources :relationships, only: [:create, :destroy]
  resources :info
  
   resources :events do
    member do
      post "add", to: "clips#create"
    end
  end

  resources :clips, only: [:destroy]
end
