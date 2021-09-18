Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :users,    only: [:create, :show, :update, :destroy]
      resources :sessions, only: [:create, :destroy]
      resources :pictures, only: [] do
        collection do
          put   'upload_picture'
          put   'upload_cover'
        end
      end
    end
  end
end
