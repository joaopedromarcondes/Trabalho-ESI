FactoryBot.define do
  factory :user do
    name { "Usuário de Teste" }
    sequence(:email) { |n| "teste#{n}@email.com" }
    password { "password123" }
    confirmed_at { Time.current }
    daily_notifications { true }
  end
end