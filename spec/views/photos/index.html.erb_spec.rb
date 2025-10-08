require 'rails_helper'

RSpec.describe "photos/index", type: :view do
  before(:each) do
    assign(:photos, [
      Photo.create!(
        foto: nil,
        latitude: 2.5,
        longitude: 3.5
      ),
      Photo.create!(
        foto: nil,
        latitude: 2.5,
        longitude: 3.5
      )
    ])
  end

  it "renders a list of photos" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.5.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.5.to_s), count: 2
  end
end
