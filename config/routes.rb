Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "verification" => "librarian#verification"
  get "index" => "librarian#index"
  get ":id/showshelf" => "librarian#showshelf"
  get "create" => "librarian#create"
  get "new" => "librarian#new"
  get "edit" => "librarian#edit"
  get "add" => "librarian#add"
  get "back" => "librarian#back"
  post "title" => "librarian#title"
  post "add" => "librarian#search"
  get ":gbapiid/addbook" => "librarian#addbook2shelf"
  get "show" => "librarian#show"
  get ":id/delete" => "librarian#delete_book"
  get ":id/shelf/delete" => "librarian#delete_shelf"
  resources :users    
  root 'top#main'  
  get 'top/main'
  post 'top/login'
  get 'top/logout'
end
