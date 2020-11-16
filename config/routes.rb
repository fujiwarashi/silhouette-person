Rails.application.routes.draw do
  devise_for :users
  get 'exams/index'
  root to: "exams#index"
  resources :exams, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :results, only: [:new, :create, :show, :destroy]
    resources :questions, only: [:index, :new, :create, :show, :edit, :destroy, :update] do
      resources :choices, only: [:create, :update]
    end
  end
  resources :users, only: :show
end