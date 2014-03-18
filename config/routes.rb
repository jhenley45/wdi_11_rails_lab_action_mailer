BooksAppWithMailer::Application.routes.draw do
  resources :books

  devise_for :users
  resources :greetings

  root to: 'books#index'

end
