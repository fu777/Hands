Rails.application.routes.draw do

  namespace :admin do
    root to: "homes#top"
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:index, :show]
    resources :blogs, only: [:index, :show, :destroy] do
      resources :blog_comments, only: [:destroy]
    end
    resources :orders, only: [:show, :index, :update]
    resources :reviews, only: [:index, :destroy]
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
    get 'customers/customer_blog/:id' => 'customers#customer_blog', as: 'customer_blog'
    resources :shops, only: [:new, :create, :index, :show, :edit, :update] do
      resource :favourite_shops, only: [:create, :destroy]
    end
    resources :shop_orders, only: [:index, :show, :update]
    resources :items, only: [:new, :create, :index, :show, :edit, :update] do
      resource :favourite_items, only: [:create, :destroy]
      collection do
        get "get_category_children", defaults: { format: "json" }
      end
      resources :reviews, only: [:create]
      get 'item_blog/:id' => 'items#item_blog', as: 'item_blog'
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
    resources :relationships, only: [:create, :destroy]
    get 'customers/followers' => 'customers#followers', as: 'followers'
    get 'customers/followings' => 'customers#followings', as: 'followings'
    resources :notices, only: [:index]
    resources :checks, only: [:index]
    resources :shop_checks, only: [:index]
  end

  get '/item_search' => 'searches#item_search', as: 'item_search'
  get '/shop_search' => 'searches#shop_search', as: 'shop_search'
  get '/customer_search' => 'searches#customer_search', as: 'customer_search'
  get '/blog_search' => 'searches#blog_search', as: 'blog_search'

  devise_scope :customer do
    post 'public/guest_sign_in', to: 'public/sessions#new_guest'
  end
  
  devise_scope :admin do
    post 'admin/guest_sign_in', to: 'admin/sessions#new_guest'
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
