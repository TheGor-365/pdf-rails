Rails.application.routes.draw do
  resources :posts
  root "pages#home"

  get "download", to: 'pages#download'
  get "preview", to: 'pages#preview'
  get 'posts/pdf/:id', to: 'posts#pdf', as: 'post_pdf'
end
