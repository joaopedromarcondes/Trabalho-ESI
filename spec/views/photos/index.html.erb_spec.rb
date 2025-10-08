require 'rails_helper'

RSpec.describe "photos/index", type: :view do
  before(:each) do
    assign(:photos, [
      FactoryBot.build_stubbed(:photo, latitude: 2.5, longitude: 3.5),
      FactoryBot.build_stubbed(:photo, latitude: 30, longitude: 27)
    ])
  end

  it "renders a list of photos" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(2.5.to_s), count: 1
    assert_select cell_selector, text: Regexp.new(3.5.to_s), count: 1
    assert_select cell_selector, text: Regexp.new(30.to_s), count: 1
    assert_select cell_selector, text: Regexp.new(27.to_s), count: 1
  end
end
