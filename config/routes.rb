Rails.application.routes.draw do

    resources :todo_lists do
        resources :tasks
    end

    root "todo_lists#index"

end
