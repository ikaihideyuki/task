Rails.application.routes.draw do
  get 'user_banks/index' => "user_banks#index"
  get 'user_banks/bank' => "user_banks#index"
  post "user_banks/bank" => "user_banks#bank"
end
