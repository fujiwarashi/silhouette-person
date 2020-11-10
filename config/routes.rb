Rails.application.routes.draw do
  devise_for :users
  get 'exams/index'
  root to: "exams#index"
  resources :exams, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :questions, only: [:index, :new, :create] do
      resources :choices, only: :create
    end
  end
end