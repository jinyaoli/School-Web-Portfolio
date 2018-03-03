Rails.application.routes.draw do

  get 'home/index'
  resources :projects

  get "project/:project_id/comments/sorted" => "comments#sorted" , as: :project_comments_sorted
  
  resources :comments, controller: :comments do
  	resources :subcomments , controller: :comments 
  	resources :up_votes
  end

  
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
