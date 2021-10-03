Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :users,    only: %i[create show update destroy]
      resources :blogs,    only: %i[index create edit update show], param: :url
      resources :my_blogs, only: %i[index]
      resources :assets,   only: %i[index create destroy]
      resources :sessions, only: %i[create destroy]
      resources :pictures, only: [] do
        collection do
          put   'upload_picture'
          put   'upload_cover'
        end
      end
    end
  end
end
