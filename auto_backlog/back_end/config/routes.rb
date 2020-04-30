Rails.application.routes.draw do
  resources :fdoc_t_ticket do
    collection do
      get 'find/pro_id=:pro_id&mile_stone=:mile_stone&status=:status', to: 'fdoc_t_ticket#index'
      get 'notify_update/ticket=:trac_id', to: 'fdoc_t_ticket#notify_update'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
