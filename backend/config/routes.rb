Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :assets,   only: %i[index create destroy]
      resources :blogs,    only: %i[index create show edit update destroy], param: :url
      resources :my_blogs, only: %i[] do
        get 'index'
        get 'index_my_stars'
        get 'index_higher_rating'
      end
      resources :sessions, only: %i[create destroy]
      resources :stars,   only: %i[create destroy]
      resources :users,    only: %i[create show update destroy]
      resources :pictures, only: [] do
        collection do
          put   'upload_picture'
          put   'upload_cover'
        end
      end
    end
  end
end
