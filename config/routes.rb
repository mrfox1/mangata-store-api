Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: :create do
        collection do
          get :profile

          put :profile, action: :update
          delete :profile, action: :destroy
        end
      end

      resources :sessions, only: :create do
        collection do
          delete :logout, action: :destroy
        end
      end

      resources :categories, only: %i( index show )
    end
  end
end
