Rails.application.routes.draw do
  get "/privacy", to: "high_voltage/pages#show", id: "privacy"
  get "/terms", to: "high_voltage/pages#show", id: "terms"
end
