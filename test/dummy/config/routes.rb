Rails.application.routes.draw do
  # not embeddable
  root 'posts#index'
  resources :posts
  get '/private', to: 'application#private'

  # is embeddable
  embeddable do
    get '/embeddable', to: 'application#embeddable'
  end
end
