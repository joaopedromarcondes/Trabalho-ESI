require 'rails_helper'

RSpec.describe Photo, type: :model do
  it "should not allow file size greater than 5MB" do
    photo = FactoryBot.build(:photo, :with_large_image)
    expect(photo).not_to be_valid
  end

  it "should allow .jpg file type" do 
    photo = FactoryBot.build(:photo)
    expect(photo).to be_valid
  end

  it "should not allow .txt file type" do
    photo = FactoryBot.build(:photo, :with_txt_file)
    expect(photo).not_to be_valid
  end

  it "should not allow latitude greater than 90" do
    photo = FactoryBot.build(:photo, latitude: 91)
    expect(photo).not_to be_valid
  end

  it "should not allow latitude less than -90" do
    photo = FactoryBot.build(:photo, latitude: -91)
    expect(photo).not_to be_valid
  end

  it "should not allow longitude greater than 180" do
    photo = FactoryBot.build(:photo, longitude: 181)
    expect(photo).not_to be_valid
  end

  it "should not allow longitude less than -180" do
    photo = FactoryBot.build(:photo, longitude: -181)
    expect(photo).not_to be_valid
  end

  it "should allow valid latitude and longitude" do
    photo = FactoryBot.build(:photo, latitude: -23.561684, longitude: -46.625378)
    expect(photo).to be_valid
  end

  it "should not allow missing latitude" do
    photo = FactoryBot.build(:photo, latitude: nil)
    expect(photo).not_to be_valid
  end

  it "should not allow missing longitude" do
    photo = FactoryBot.build(:photo, longitude: nil)
    expect(photo).not_to be_valid
  end

  it "should not allow missing photo attachment" do
    photo = FactoryBot.build(:photo)
    photo.foto.detach
    expect(photo).not_to be_valid
  end

  it "should not allow non-numeric latitude" do
    photo = FactoryBot.build(:photo, latitude: "invalid")
    expect(photo).not_to be_valid
  end

  it "should not allow non-numeric longitude" do
    photo = FactoryBot.build(:photo, longitude: "invalid")
    expect(photo).not_to be_valid
  end
end
