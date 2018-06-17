Rails.application.routes.draw do
  root 'parse#new'

  resources :parse, :only => [:index, :new, :create]
end
