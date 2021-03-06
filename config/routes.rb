TProcess::Application.routes.draw do
  scope module: 'admin', :constraints => { :subdomain => 'admin' } do
     root 'dashboard#index', :as => :admin

     resources :user_role
     resources :user_approval
     resources :firewalls
     
     scope '/user_role/edit/' do
        get "select_project/:project_id" => 'user_role#select_project', :as => 'select_project'
        get "add_curriculum/:curriculum_id" => 'user_role#add_curriculum', :as => 'add_curriculum'
        get "remove_curriculum/:curriculum_id" => 'user_role#remove_curriculum', :as => 'remove_curriculum'
     end

     get "boards/index"
     delete "boards/:id" => 'boards#remove_board', :as => 'delete_board'
     get "messagess/index"
     delete "messagess/:id" => 'messagess#remove_message', :as => 'delete_message'
     get "curriculums/index"
     delete "curriculums/:id" => 'curriculums#remove_curriculum', :as => 'delete_curriculum'
     get "projects/index"
     delete "projects/id" => 'projects#remove_project', :as => 'delete_project'
  end

  scope '/projects/:project_id' do
    get "project_progress" => 'project_progress#index'
    #메세지
    resources :messages 
    #
    resources :progress_types
    #달력
    resources :calendars
    
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

    # #캘린더
    # resources :events do 
    #   collection do 
    #     get :get_events
    #   end
    #   member do
    #     post :move
    #     post :resize
    #   end
    # end
  end

  resources :projects

  devise_for :users, :controllers => { :registrations => "registrations" }    

  root :to => 'projects#index'
end