Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  namespace :admin do
    resources :projects do
      member do
        put 'archive'
        put 'activate'
      end
      resources :project_teams, only: :show do
        resources :tasks, only: [:new, :create,:update,:edit,:destroy]
      end
    end
    
    resources :workshops
    resources :events do
      member do
        put 'archive'
        put 'activate'
      end
    end
    resources :users, only: [:index, :show] do
      post 'accept', on: :member
      post 'promote', on: :member
    end

    resource :dashboard, only: :show

    resources :teams do
      resources :annual_tasks, only: [:new, :create]
    end
  end

  resources :projects
  resources :teams
  resources :events
  resources :user_tasks, only: [:create, :destroy, :edit, :update]
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :edit, :update]
  resource :dashboard, only: :show

  resources :memberships do
    post :reject, on: :collection
  end

  resources :events, only: [:show] do
    post :join, on: :member
  end

  resources :password_resets,     only: [:new, :create, :edit, :update]

  root 'welcomes#show'
end
