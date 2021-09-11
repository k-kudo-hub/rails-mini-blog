Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :users,    only: [:create, :show, :update, :destroy] do
        collection do
          put   'upload'
          patch 'upload'
        end
      end
      resources :sessions, only: [:create, :destroy]
    end
  end
end
