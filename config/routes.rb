Thedc2013::Application.routes.draw do
  #devise_for :admin_users, ActiveAdmin::Devise.config
  #ActiveAdmin.routes(self)

  namespace :admin do
    root to: 'static_pages#home'
    resources :users
    resources :teams
    match 'print/teams', to: 'teams#print', via: 'get', as: 'print_teams'

    resources :events
    match 'print/events/:id', to: 'events#print', via: 'get', as: 'print_event'
    match 'print_survived/teams', to: 'teams#print_survived', via: 'get', as: 'print_teams_survived'

    resources :periods
    resources :trials
    match 'revert/trial/:id', to: 'trials#revert', via: 'patch', as: 'revert_trial'
    resources :duels

    resources :posts
    resources :replies

    resources :informs
    resources :docs
  end

  root to: 'static_pages#home'

  match '/about', to: 'static_pages#about', via: 'get'

  match '/signup', to: 'users#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  resources :users
  match 'users/:id/delete', to: 'users#delete', via: 'get', as: 'delete_user'

  resources :teams
  resources :teams, only: [:index, :show]
  match 'teams/:id/delete', to: 'teams#delete', via: 'get', as: 'delete_team'

  resources :memberships, only: [:destroy]

  resources :invitations, only: [:destroy]
  match 'invitations/create/:user_id', to: 'invitations#create', via: 'post', as: 'invite_user'
  match 'invitations/:id/accept', to: 'invitations#accept', via: 'post', as: 'accept_invitation'
  match 'invitations/:id/decline', to: 'invitations#decline', via: 'post', as: 'decline_invitation'
  match 'invitations/:id/cancel', to: 'invitations#cancel', via: 'post', as: 'cancel_invitation'

  match 'applies/create/:team_id', to: 'applies#create', via: 'post', as: 'apply_team'
  match 'applies/:id/accept', to: 'applies#accept', via: 'post', as: 'accept_apply'
  match 'applies/:id/decline', to: 'applies#decline', via: 'post', as: 'decline_apply'
  match 'applies/:id/cancel', to: 'applies#cancel', via: 'post', as: 'cancel_apply'

  resources :sessions, only: [:create, :destroy]
  resources :events, only: [:index, :show]
  resources :posts
  resources :replies, only: [:create]
  resources :informs, only: [:index, :show]
  resources :docs, only: [:index]
  resources :password_resets, only: [:new, :create, :edit, :update]

  match 'periods/:id/add/:team_id', to: 'periods#add', via: 'post', as: 'period_add_team'
  match 'periods/:id/remove/:team_id', to: 'periods#remove', via: 'post', as: 'period_remove_team'
  
end
