TProcess::Application.routes.draw do
  scope '/projects/:project_id' do
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

  devise_for :users

  root to: "projects#index"
end