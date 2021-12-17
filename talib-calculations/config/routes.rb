Rails.application.routes.draw do
  namespace :calculation do
    post 'rsi'
    post 'macd'
  end
end
