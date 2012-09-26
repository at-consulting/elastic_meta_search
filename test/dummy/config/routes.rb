Rails.application.routes.draw do

  resources :posts

  match '/fs' => "application#fs", as: :fs
end
