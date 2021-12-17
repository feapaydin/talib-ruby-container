Rails.application.routes.draw do
  namespace :calculation do
    post 'rsi'
  end
end
