Rails.application.routes.draw do
  resources :criteria_types
  resources :roles
  resources :position_types
  resources :criteria do
    collection {post :import}
  end
  resources :degrees
  resources :companies do
    resources :business_units, shallow: true
    resources :job_titles
    resources :areas, shallow: true do
      resources :job_titles, shallow: true
    end
    resources :valuations, shallow: true do
      resources :historics
      collection {post :import}
    end
  end

  get    '/login',   to: 'session#new'
  post   '/login',   to: 'session#create'
  delete '/logout',  to: 'session#destroy'

  resources :users

  get '/companies/:id/report_matrix_simple', to: 'companies#report_matrix_simple'
  get '/companies/:id/map_detailed', to: 'companies#map_detailed'
  get '/companies/:id/reports', to: 'companies#reports'
  get '/home', to: 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact',  to: 'static_pages#contact'
  get '/settings', to: 'static_pages#settings'
  get '/references_tables', to: 'static_pages#references_tables'
  get '/menu', to: 'static_pages#menu'

  root 'static_pages#home'

  get '/signup', to: 'users#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
