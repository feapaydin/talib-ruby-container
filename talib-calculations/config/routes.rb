Rails.application.routes.draw do
  post 'calculation/:function_name', to: 'calculation#technical_analysis'
end
