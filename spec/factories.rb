FactoryGirl.define do
  factory :ad do
    title 'test'
    description 'description'
    city 'minsk'
    price 1
    user_id 1
    section_id 1
  end

  factory :cuc_user, :class => User do
    name 'Cucumber'
    role :user
    email 'example@example.com'
    password 'cucumber'
    password_confirmation 'cucumber'
  end

  factory :user do
    name 'User'
    role :user
    email 'user@example.com'
    password 'user123'
    password_confirmation 'user123'
  end

  factory :admin do
    name 'Admin'
    role :admin
    email 'admin@example.com'
    password 'admin123'
    password_confirmation 'admin123'
  end

end
