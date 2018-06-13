Rails.application.routes.draw do
  get 'votes/create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    get '/myquestions' => 'questions#myquestions', :as => :myquestions
    resources :questions do
      resources :comments do
        resources :votes
      end
    end
  end
end
