Ads::Application.routes.draw do
  devise_for :users
  resources :users
  resources :sections

  resources :ads do
    collection do
      match '/index' => 'ads#index'
      match 'manage' => 'ads#manager', :as => :manage
      match 'search' => 'ads#index', :via => [:get, :post], :as => :search
      match '/destroy' => 'ads#destroy', :as => :destroy
      match 'draft' => 'ads#draft', :as => :draft
      match 'ready' => 'ads#ready', :as => :ready
      match 'reject' => 'ads#reject', :as => :reject
      match 'approve' => 'ads#approve', :as => :approve
      match 'publish' => 'ads#publish', :as => :publish
      match 'archive' => 'ads#archive', :as => :archive
    end
  end

  root :to => "ads#index"
end
