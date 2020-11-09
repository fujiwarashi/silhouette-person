Rails.application.routes.draw do
  devise_for :users
  get 'exams/index'
  root to: "exams#index"
end