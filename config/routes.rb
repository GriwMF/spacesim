Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount ActionCable.server => '/cable' if Rails.env.development?
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'homepage#index'

  scope '/:locale' do
    resource :subscription, only: :create
  end
  resource :subscription, only: :create

  get '/history', to: 'homepage#history' if Rails.env.development?
  get '/bc', to: 'homepage#bc' if Rails.env.development?
  get '/ship_data', to: 'homepage#ship_data' if Rails.env.development?
  get '/:locale', to: 'homepage#index', as: :root_with_locale
end
