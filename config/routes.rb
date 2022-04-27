Rails.application.routes.draw do
  root 'reports#new'

  resources :reports, except: %i[index edit update]
  get 'reports/:id/download', to: 'reports#download', as: 'report_download'
end
