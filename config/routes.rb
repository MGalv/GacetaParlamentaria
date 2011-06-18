Opendata::Application.routes.draw do

  match '/gacetas' => 'api#gazettes'
  
end
