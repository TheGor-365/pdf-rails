Rails.application.routes.draw do
  root "pages#home"

  get "download", to: 'pages#download'
  get "preview", to: 'pages#preview'
end
