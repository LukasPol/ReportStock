Rails.application.routes.draw do
  resources :reports, except: %i[index edit update]

  root 'reports#new'
end
