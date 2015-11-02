Rails.application.routes.draw do
  namespace :admin do
    resources :projects do
      member do
        put 'archive'
        put 'activate'
      end
    end

    resource :dashboard, only: :show
  end

  resources :projects
  resources :events
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :index, :show, :edit]
  resource :dashboard, only: :show

  resources :memberships do
    post :reject, on: :collection
  end

  root 'welcome#index'
end
