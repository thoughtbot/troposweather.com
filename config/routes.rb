Rails.application.routes.draw do
  get "/privacy", to: "high_voltage/pages#show", id: "privacy"
end
