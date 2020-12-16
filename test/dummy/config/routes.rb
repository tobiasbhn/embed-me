Rails.application.routes.draw do
  default_url_options :host => "example.com"

  # not embeddable
  get '/private', to: 'application#private'

  # is embeddable
  embeddable do
    root 'posts#index'
    resources :posts
    get '/embeddable', to: 'application#embeddable'
  end
end
