Rails.application.routes.draw do
  root "static_pages#home"
  get "about" => "static_pages#about"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  resources :users, only: [:show, :edit, :update] do
    resources :relationships, only: [:index]
  end
  resources :relationships, only: [:create, :destroy]
  namespace :supervisor do
    resources :users
    resources :subjects
    resources :courses do
      resources :course_subjects, only: [:show] do
        resource :active_subjects, only: [:update]
      end
      resource :active_courses, only: [:update]
    end
    resources :user_courses, only: :destroy
    resources :assign_trainees, only: [:edit, :update]
  end
end
