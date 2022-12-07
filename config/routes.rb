Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "verification" => "librarian#verification"
  get "index" => "librarian#index"
  get "showshelf" => "librarian#showshelf"
  get "create" => "librarian#create"
  get "new" => "librarian#new"
  get "edit" => "librarian#edit"
  get ":id/add" => "librarian#add"
  get ":id/back" => "librarian#back"
  post ":from/title" => "librarian#title"
  resources :users    
  root 'top#main'  
  get 'top/main'
  post 'top/login'
  get 'top/logout'
end
