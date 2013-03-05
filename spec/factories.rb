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

end
