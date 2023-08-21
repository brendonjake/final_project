Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  constraints(ClientDomainConstraint.new) do
    root 'client/home#index', as: 'client_root'
    devise_for :users, controllers: {
      sessions: 'client/sessions', registrations: 'client/registrations'
    }, as: 'client'
    namespace :client, path: '' do
      resource :profiles, only: [:show, :edit, :update]
      resources :addresses
      resources :invite_peoples
      resources :lotteries, only: [:index, :show, :create]
    end
  end

  constraints(AdminDomainConstraint.new) do
    root 'admin/home#index', as: 'admin_root'
    devise_for :users, controllers: {
      sessions: 'admin/sessions'
    }, as: 'admin'
    namespace :admin, path: '' do
      resources :users, only: [:index]
      resources :items do
        put :start
        put :pause
        put :end
        put :cancel
      end
      resources :categories
      resources :bets do
        put :cancel
      end
      resources :winners do
        put :submit
        put :pay
        put :ship
        put :deliver
        put :publish
        put :remove_publish
      end

      # namespace :admin do
      # end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :regions, only: %i[index show], defaults: { format: :json } do
        resources :provinces, only: :index, defaults: { format: :json }
      end

      resources :provinces, only: %i[index show], defaults: { format: :json } do
        resources :cities, only: :index, defaults: { format: :json }
      end

      resources :cities, only: %i[index show], defaults: { format: :json } do
        resources :barangays, only: :index, defaults: { format: :json }
      end

      resources :barangays, only: %i[index show], defaults: { format: :json }
    end
  end
end
