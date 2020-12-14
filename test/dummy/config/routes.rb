Rails.application.routes.draw do
  root 'posts#index'
  resources :posts
  # mount EmbedMe::Engine => "/embed_me"
end
