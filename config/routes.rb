TrackerPoker::Application.routes.draw do

  match "pivotal" => "pivotal#login_pivotal", :as => :pivotal
  match "pivotal/login" => "pivotal#auth_pivotal", :as => :pivotal_login
  # match "pivotal/project/:project_id/stories" => "pivotal#stories", :as => :project_story
  # match "pivotal/project/:project_id/ice_box" => "pivotal#ice_box", :as => :project_ice_box
  # match "pivotal/projects" => "pivotal#projects", :as => :pivotal_projects

  devise_for :users

  match "about" => "page#about", :as => :about

  match "contact" => "page#contact", :as => :contact
  resources :token, :only =>[:create, :delete] do
    post "fetch", :on => :collection
  end
  resources :room do
    resources :story do
      post 'vote', :on => :member
      get 'votes', :on => :member
      get 'open_voting', :on => :member
      get 'close_voting', :on => :member
      get 'status_voting', :on => :member
      get 'icebox', :on => :collection
    end
    get 'active_story', :on => :member
    get 'join', :on => :member
  end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'page#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
