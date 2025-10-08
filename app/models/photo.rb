class Photo < ApplicationRecord
  has_one_attached :foto


  validates :foto,
            attached: true,
            content_type: {in: ['image/jpeg', 'image/png'], message: 'deve ser JPEG ou PNG'},
            size: { less_than: 5.megabytes, message: 'deve ser menor que 5MB' }
  

  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  
end
