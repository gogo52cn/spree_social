Spree::Core::Engine.add_routes do
  devise_for :spree_user,
             class_name: Spree::User,
             skip: [:unlocks, :sessions, :registrations, :passwords],
             controllers: { omniauth_callbacks: 'spree/omniauth_callbacks' },
             path: Spree::SocialConfig[:path_prefix]
  resources :user_authentications
  
    devise_scope :spree_user do
    match "/users/auth/:provider",
      constraints: { provider: /google|facebook/ },
      to: "spree/omniauth_callbacks#passthru",
      as: :user_omniauth_authorize,
      via: [:get, :post]
    match "/users/auth/:action/callback",
      constraints: { action: /google|facebook/ },
      to: "spree/omniauth_callbacks",
      as: :user_omniauth_callback,
      via: [:get, :post]
  end
  

  get 'account' => 'users#show', as: 'user_root'

  namespace :admin do
    resources :authentication_methods
  end
end
