Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    get '/myquestions' => 'questions#myquestions', :as => :myquestions
    resources :questions do
      resources :comments
    end
  end
end
