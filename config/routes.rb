Spree::Core::Engine.add_routes do

 #     devise_scope :user do
  #  match "/users/auth/:provider",
   #   constraints: { provider: /google|facebook/ },
   #   to: "spree/omniauth_callbacks#passthru",
   #   as: :user_omniauth_authorize,
   #   via: [:get, :post]

 # end
  
  devise_for :spree_user,
             class_name: Spree::User,
             skip: [:unlocks, :sessions, :registrations, :passwords],
             controllers: { omniauth_callbacks: 'spree/omniauth_callbacks' },
             path: Spree::SocialConfig[:path_prefix]
  
    
  #devise_scope :spree_user do

  #match "/users/auth/:provider",
  #    constraints: { provider: /google|facebook/ },
  #   to: "omniauth_callbacks#passthru",
  #   as: :spree_user_omniauth_authorize,
  #    via: [:get, :post]

  #match "/users/auth/:action/callback",
  #    constraints: { action: /google|facebook/ },
  #    to: "omniauth_callbacks",
  #    as: :spree_user_omniauth_callback,
  #    via: [:get, :post]
  #end
  
  devise_scope :spree_user do
  match "/users/auth/:action/callback",
      constraints: { action: /google|facebook/ },
      to: "omniauth_callbacks",
      as: :spree_user_omniauth_callback_backup,
      via: [:get, :post]
  end

  resources :user_authentications

  get 'account' => 'users#show', as: 'user_root'

  namespace :admin do
    resources :authentication_methods
  end


end
