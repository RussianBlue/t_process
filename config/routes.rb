TProcess::Application.routes.draw do
  scope module: 'admin', :constraints => { :subdomain => 'admin' } do
     root 'dashboard#index', :as => :admin
     get "users/" => 'user_role#index', :as => :users
     get "users/show/:id"  => 'user_role#show', :as => 'user_show'
     get "users/edit/:id" => 'user_role#edit',  :as => 'user_edit'
     put "users/update/:id" => 'user_role#update',  :as => 'user_update'
     delete "users/destroy/:id" => 'user_role#destroy',  :as => 'user_remove'
  end

  scope '/projects/:project_id' do
    get "project_progress" => 'project_progress#index'
    resources :messages 

    resources :progress_types
    
    resources :curriculums do
      resources :progresses
      resources :products do
         member do 
          get :p_download
          get :s_download
        end
      end
      
      get '/progress_edit'      => 'progresses#multi_edit', :as => :progress_edit
      patch '/progress_edit/'   => 'progresses#multi_update', :as => :multi_update
      delete '/remove/'         => 'progresses#progress_remove', :as => :progress_remove
    end

    resources :notices do
      member do 
        get :download
      end
    end

    controller :project_dashboard do
      get "dashboard" => 'project_dashboard#index', :as => 'dashboard'
    end
  end

  resources :projects

  devise_for :users, :controllers => { :registrations => "registrations" }  

  root :to => 'projects#index'
end