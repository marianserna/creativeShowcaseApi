Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :videos, only: [:index, :create] do
    collection do
      get :motion
      get :vr
      get :interactive
      get :featured
    end

    member do
      post :heart
    end
  end
end
