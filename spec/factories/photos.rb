FactoryBot.define do
  factory :photo do

    # Padrao
    latitude { -23.561684 }
    longitude { -46.625378 }

    after(:build) do |photo|
      photo.foto.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'foto-valida.jpg')), filename: 'foto-valida.jpg', content_type: 'image/jpeg')
    end

    # Variações
    trait :with_large_image do
      after(:build) do |photo|
        photo.foto.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'foto-grande.jpg')), filename: 'foto-grande.jpg', content_type: 'image/jpeg')
      end
    end

    trait :with_txt_file do
      after(:build) do |photo|
        photo.foto.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'foto-invalida.txt')), filename: 'foto-invalida.txt', content_type: 'text/plain')
      end
    end
  end
end
