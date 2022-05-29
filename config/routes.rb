Rails.application.routes.draw do

  namespace :admin do
    root to: "homes#top"
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:index, :show]
    resources :blogs, only: [:index, :show, :destroy] do
      resources :blog_comments, only: [:destroy]
    end
    resources :orders, only: [:show, :index, :update]
  end
  
  scope module: :public do
    root to: "homes#top"
    get '/about' => 'homes#about', as: 'about'
    get 'customers/unsubscribe', as: 'unsubscribe'
    patch 'customers/withdraw', as: 'withdraw'
    get 'customers/my_page/:id' => 'customers#show', as: 'my_page'
    get 'customers/edit' => 'customers#edit', as: 'edit'
    patch 'customers' => 'customers#update', as: 'update'
    get 'customers' => 'customers#index', as: 'index'
    get 'customers/profile_edit' => 'customers#profile_edit', as: 'profile_edit'
    patch 'customers/profile_update' => 'customers#profile_update', as: 'profile_update'
    get 'customers/good' => 'customers#good', as: 'good'
    get 'customers/favourite_item' => 'customers#favourite_item', as: 'favourite_item'
    get 'customers/favourite_shop' => 'customers#favourite_shop', as: 'favourite_shop'
    resources :shops, only: [:new, :create, :index, :show, :edit, :update] do
      resource :favourite_shops, only: [:create, :destroy]
    end
    resources :shop_orders, only: [:index, :show, :update]
    resources :items, only: [:new, :create, :index, :show, :edit, :update] do
      resource :favourite_items, only: [:create, :destroy]
      collection do
        get "get_category_children", defaults: { format: "json" }
      end
    end
    resources :blogs do
      resources :blog_comments, only: [:create, :destroy]
      resource :goods, only: [:create, :destroy]
    end
    post 'orders/confirm' => 'orders#confirm', as: 'confirm'
    get 'orders/complete' => 'orders#complete', as: 'complete'
    resources :carts, only: [:index, :destroy, :create] do
      collection do
        delete 'destroy_all'
      end
      resources :cart_items, only: [:update, :destroy]
    end
    resources :orders, only: [:new, :create, :index, :show, :update]
  end

  get '/item_search' => 'searches#item_search', as: 'item_search'
  get '/shop_search' => 'searches#shop_search', as: 'shop_search'

  devise_scope :customers do
    post 'customers/guest_sign_in', to: 'customers/sessions#new_guest'
  end

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
