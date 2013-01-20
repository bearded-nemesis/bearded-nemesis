# This will guess the User class
FactoryGirl.define do
  factory :user do
    email
    password "password"
    password_confirmation "password"
    admin false

    before :create do |user|
      Admin::Whitelist.create! email: user.email
    end
  end

  # This will use the User class (Admin would have been guessed)
  factory :admin, class: User do
    admin true
  end

  factory :song do
    name { generate(:song_name) }
    artist
    genre
    shortname
  end

  factory :playlist do
    name { generate :playlist_name }
  end

  sequence :playlist_name do |n|
    "Playlist #{n}"
  end

  sequence :song_name do |n|
    "Song #{n}"
  end

  sequence :artist do |n|
    "Artist #{n}"
  end

  sequence :genre do |n|
    "Genre #{n}"
  end

  sequence :shortname do |n|
    "song#{n}"
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end
end