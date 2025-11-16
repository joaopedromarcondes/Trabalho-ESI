class NoiseMeasurement < ApplicationRecord
    belongs_to :user, optional: true
    # possui latitude, longitude e level (em dB)
end
