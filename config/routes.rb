Rails.application.routes.draw do

  resources :includeds do
    member do
      put 'include', to: 'includeds#include'
      put 'exclude', to: 'includeds#exclude'
      get 'csv', to: 'includeds#csv'
    end
  end

  resources :springers do
    member do
      put 'select', to: 'springers#select'
      put 'unselect', to: 'springers#unselect'
    end
  end

  resources :scopus do
    member do
      put 'select', to: 'scopus#select'
      put 'unselect', to: 'scopus#unselect'
    end
  end

  resources :scidirs do
    member do
      put 'select', to: 'scidirs#select'
      put 'unselect', to: 'scidirs#unselect'
    end
  end
  resources :acms do
    member do
      put 'select', to: 'acms#select'
      put 'unselect', to: 'acms#unselect'
    end
  end

  resources :references
  resources :protocols do
    member do
      # Using member you create a route for that specific protocol, e.g. 'protocols/5/search'
      # Otherwise, using collection you can create a route without a specific id :)
      get 'search'
      post 'do_search'
      get 'selected'
      get 'included'
    end
  end

  resources :ieees do
    member do
      put 'select', to: 'ieees#select'
      put 'unselect', to: 'ieees#unselect'
    end
  end

  get 'terms_of_service', to: 'home#terms_of_service'
  get 'privacy_policy', to: 'home#privacy_policy'
  get 'community_rules', to: 'home#community_rules'
  get 'user_manual', to: 'home#user_manual'

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'protocols#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
