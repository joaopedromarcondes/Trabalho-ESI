require 'rails_helper'

RSpec.describe "photos/index", type: :view do
  before(:each) do
    assign(:photos, [
      FactoryBot.create(:photo, latitude: 2.5, longitude: 3.5),
      FactoryBot.create(:photo, latitude: 30, longitude: 27)
    ])
  end

  it "renders a map with photo markers" do
    render
    expect(rendered).to have_selector('#map')
  end
end
