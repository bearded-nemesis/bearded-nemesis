BeardedNemesis::Application.routes.draw do
  devise_for :views

  resources :performances do
    member do
      post :rate
    end
  end

  resources :playlists do
    member do
      get :auto
      post :generate
      get :play
    end

    resources :players, controller: "playlist_player"
  end

  resources :rock_parties

  resources :playlist_song

  namespace :admin do resources :whitelists end

  devise_for :users, path: "accounts"
  resources :users do
    member do
      get :import
      post :do_import
    end
  end

  resources :friendships

  resources :songs do
    resources :ratings

    collection do
      get :mine
      get "search" => "songs#search"
      get "search/:term" => "songs#search", constraints: { term: /.*/ }
      get "autocomplete" => "songs#autocomplete"
    end

    member do
      post :own
    end
  end

  get "/genres" => "genres#index"
  get "/genres/:name" => "genres#show", as: "show_genres"
  get "/artists" => "artists#index"
  get "/artists/:name" => "artists#show", as: "show_artists"

  namespace :admin do
    resources :users
  end

  root :to => "home#index"
end
