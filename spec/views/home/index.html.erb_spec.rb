require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do
  it "renders the home page" do
    render
    expect(rendered).to match /Olá, Mundo!/
  end
end
