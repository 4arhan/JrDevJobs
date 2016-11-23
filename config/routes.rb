Rails.application.routes.draw do
  resources :schools
  resources :experiences
  resources :profiles
  resources :jobs
  resources :transactions, only: [:create]
  resources :searches
  # mailbox folder routes
  get "inbox" => "mailbox#inbox", as: 'inbox'
  get "sent" => "mailbox#sent", as: 'sent'
  get "trash" => "mailbox#trash", as: 'trash'

  # conversations
  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end
  devise_scope :user do
    get "candidate" => "devise/registrations#new", :role => 'candidate'
    get "company" => "devise/registrations#new", :role => 'company'
  end
  devise_for :users, controllers: { registrations: "registrations"}
  root 'home#index'
  get 'home/candidates', to: 'home#candidates', as: 'candidates'
  get 'home/companies', to: 'home#companies', as: 'companies'
  get 'home/jobs_listing', to: 'home#jobs_listing', as: 'jobs_listing'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
