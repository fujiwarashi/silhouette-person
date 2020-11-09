Rails.application.routes.draw do
  get 'exams/index'
  root to: "exams#index"
end