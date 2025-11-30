FactoryBot.define do
  factory :health_symptom do
    sintoma { "Febre" }
    intensidade { :alto }

    user
  end
end
