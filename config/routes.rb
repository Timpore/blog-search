Rails.application.routes.draw do
  resources :posts, path: '/:domain', only: %i(index)

  get ':domain', to: 'posts#index'
  get ':domain/:slug', to: 'posts#show'
end
