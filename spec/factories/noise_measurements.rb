FactoryBot.define do
  factory :noise_measurement do
    association :user
    latitude { -23.55 + rand * 0.1 }
    longitude { -46.63 + rand * 0.1 }
    level { rand(40..100) }
  end
end

