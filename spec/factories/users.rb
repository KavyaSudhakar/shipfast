FactoryBot.define do
    factory :user do
      sequence(:full_name) { |n| "John Doe#{n}" }
      sequence(:email) { |n| "john#{n}@example.com" }
      password { "password" }
      role { :customer }
    end
  end
  