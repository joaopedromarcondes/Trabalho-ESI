FactoryBot.define do
  factory :audio_submission do
    latitude { -23.5 }
    longitude { -46.6 }
    duration_seconds { 10 }
    association :user

    after(:build) do |a|
      if File.exist?(Rails.root.join('spec', 'fixtures', 'files', 'audio-valid.mp3'))
        a.audio.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'audio-valid.mp3')), filename: 'audio-valid.mp3', content_type: 'audio/mpeg')
      else
        require 'stringio'
        io = StringIO.new("\x00\x01\x02")
        a.audio.attach(io: io, filename: 'audio-valid.mp3', content_type: 'audio/mpeg')
      end
    end
  end
end
