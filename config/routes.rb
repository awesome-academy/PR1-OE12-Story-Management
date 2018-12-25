Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/help", to: "static_pages#help"
    get "/about", to: "static_pages#about"
    get "/contact",to: "static_pages#contact"
    get "/signup", to: "members#new"
    post "/signup", to: "members#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    get "/like_unlike", to: "static_pages#like_unlike", as: "like_unlike"
    delete "/logout", to: "sessions#destroy"
    get  "/post", to: "stories#new"
    post "/post", to: "stories#create"
    get "/load_story", to: "story#selectstory", as: "load_story"
    resources :stories
    resources :story
    resources :comments
    resources :authors
    resources :chapters
    resources :relationships, only: [:create, :destroy]
    resources :members do
      member do
        get :following, :followers
      end
    end
  end
end
