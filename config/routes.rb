Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  namespace :admin do
    resources :projects do
      member do
        put 'archive'
        put 'activate'
      end
    end

    resources :workshops

    resources :users, only: [:index, :show] do
      post 'accept', on: :member
      post 'promote', on: :member
    end

    resource :dashboard, only: :show
    resources :teams
  end

  resources :projects
  resources :teams
  resources :events
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :edit, :update] 
  resource :dashboard, only: :show

  resources :memberships do
    post :reject, on: :collection
  end

  resources :password_resets,     only: [:new, :create, :edit, :update]

  root 'welcomes#show'
end
