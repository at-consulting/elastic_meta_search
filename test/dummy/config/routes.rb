Rails.application.routes.draw do

  resources :posts do
    collection do
      get 'es'
    end

  end

end
