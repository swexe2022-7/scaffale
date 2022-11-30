Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "verification" => "librarian#verification"
  get "index" => "librarian#index"
  get "showshelf" => "librarian#showshelf"
  get "new" => "librarian#new"
  get "edit" => "librarian#edit"
  get ":id/add" => "librarian#add"
  get ":id/back" => "librarian#back"
end
