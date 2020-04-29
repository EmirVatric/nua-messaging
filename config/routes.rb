Rails.application.routes.draw do

  root :to => 'messages#index'

  get 'current-user/:type', to: 'sessions#change_user', as: 'change_user'
  get 'lost-script', to: 'payments#lost_script', as: 'lost_script'

  resources :messages

end
