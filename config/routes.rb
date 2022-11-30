Rails.application.routes.draw do
    resources :users
    
    root 'top#main'
    
    get 'top/main'
    post 'top/login'
    get 'top/logout'
end
