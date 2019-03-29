FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@factory.com" }
    password { 'string' }
    factory :visitor do
      role { 0 }
      sequence(:email) { |n| "user_#{n}@factory.com" }
    end
    factory :journalist do
      role { 1 }
      sequence(:email) { |n| "user_#{n}@factory.com" }
     end
  end
end
