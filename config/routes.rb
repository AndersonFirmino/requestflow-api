Rails.application.routes.draw do
  post 'auth/login', to: 'auth#login'
  resources :requests, only: [:index, :create]
  put 'requests/:id/approve', to: 'requests#approve'
  put 'requests/:id/reject', to: 'requests#reject'
end
