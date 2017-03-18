Rails.application.routes.draw do
  scope module: :web do
    root to: 'welcome#index'

    resource :password, only: [:edit, :update]
    resource :session, only: [:new, :create, :destroy]
    get 'login' => 'sessions#new'
    get 'logout' => 'sessions#destroy'

    namespace :admin do
      root to: 'welcome#index'
      resources :dishes, only: [:index, :edit, :new, :create, :update, :destroy]
      resources :user_menus, only: [:index]
      resources :users, only: [:index, :new, :create, :edit, :update, :destroy]
      resources :menus, param: :date, only: [:edit, :update] do
        member do
          put :approve
        end
      end
    end
  end

  namespace :api do
    resources :users, only: [:index, :show, :update] do
      scope module: :users do
        resources :menus, only: [:index]
      end
    end
    resources :dishes, only: [:index, :create, :update, :destroy]
    resources :menus, only: [:index, :create, :update, :destroy]
    resources :user_menus, only: [:index, :update]
  end

  match '*path' => 'web/welcome#index', via: :get
end
