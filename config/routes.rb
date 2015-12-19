Rails.application.routes.draw do
  namespace :admin do
    resources :projects do
      put :archive, on: :member
      put :activate, on: :member
      resources :project_teams, only: :show do
        resources :tasks, only: [:new, :create, :update, :edit, :destroy]
      end
    end

    resources :events do
      put :archive, on: :member
      put :activate, on: :member
      get :attendence_logs
      get :charges_logs
    end

    resources :event_attendences do
      put :charge_fee
      put :commit_attendence
      put :charge_undo
      put :undo_attendence
    end

    resources :users, only: [:index, :show] do
      post :accept, on: :member
      post :promote, on: :member
    end

    resources :teams do
      resources :annual_tasks, only: [:new, :create]
    end

    resources :workshops
    resource :dashboard, only: :show
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


  resources :password_resets, only: [:new, :create, :edit, :update]

  get 'password_resets/new'
  get 'password_resets/edit'
  root 'welcomes#show'
end
