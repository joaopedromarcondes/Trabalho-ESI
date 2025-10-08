require 'rails_helper'

RSpec.describe "photos/new", type: :view do
  before(:each) do
    assign(:photo, Photo.new(
      foto: nil,
      latitude: 1.5,
      longitude: 1.5
    ))
  end

  it "renders new photo form" do
    render

    assert_select "form[action=?][method=?]", photos_path, "post" do

      assert_select "input[name=?]", "photo[foto]"

      assert_select "input[name=?]", "photo[latitude]"

      assert_select "input[name=?]", "photo[longitude]"
    end
  end
end
