require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do

  before(:each) do
    assign(:photos, [
      create(:photo),
      create(:photo)
    ])
  end

  it "renders the home page" do
    render
    expect(rendered).to match /Bem-vindo!/
  end
end
