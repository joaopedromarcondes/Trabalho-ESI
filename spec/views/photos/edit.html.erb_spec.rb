require 'rails_helper'

RSpec.describe "photos/edit", type: :view do
  let(:photo) {
    Photo.create!(
      foto: nil,
      latitude: 1.5,
      longitude: 1.5
    )
  }

  before(:each) do
    assign(:photo, photo)
  end

  it "renders the edit photo form" do
    render

    assert_select "form[action=?][method=?]", photo_path(photo), "post" do

      assert_select "input[name=?]", "photo[foto]"

      assert_select "input[name=?]", "photo[latitude]"

      assert_select "input[name=?]", "photo[longitude]"
    end
  end
end
