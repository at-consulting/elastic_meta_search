Rails.application.routes.draw do

  resources :posts

  match '/es' => "application#es", as: :es
end
