Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  constraints(ClientDomainConstraint.new) do
    root 'client/home#index', as: 'client_root'
    devise_for :users, controllers: {
      sessions: 'client/sessions', registrations: 'client/registrations'
    }, as: 'client'
    namespace :client, path: '' do
      resource :profiles, only: [:show,  :edit, :update]
    end
  end

  constraints(AdminDomainConstraint.new) do
    root 'admin/home#index', as: 'admin_root'
    devise_for :users, controllers: {
      sessions: 'admin/sessions'
    }, as: 'admin'
    # namespace :admin do
    # end
  end
end
