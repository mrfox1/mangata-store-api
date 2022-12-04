Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :sessions, only: %i(create) do
        collection do
          delete :logout, action: :destroy
          post :social_login
        end
      end

      resources :categories, only: %i( index show )
    end
  end
end
