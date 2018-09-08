require 'sidekiq/web'

Rails.application.routes.draw do
  get 'login', to: redirect('/auth/google_oauth2'), as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'home', to: 'home#show'
  get 'me', to: 'me#show', as: 'me'

  root to: "home#show"
end

class Subdomain
  def self.matches?(request)
    resources :exercises
    subdomains = %w{www admin}
    request.subdomain.present? && !subdomains.include?(request.subdomain)
  end

constants Subdomain do
  resources :workouts

end

def
  devise_for users:{ omniauth_callbacks: 'users/omniauth_callbacks' }, controllers:
  root to: 'home#index'
  end
end 
