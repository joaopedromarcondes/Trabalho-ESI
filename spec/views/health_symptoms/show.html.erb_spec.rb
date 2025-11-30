require 'rails_helper'

RSpec.describe "health_symptoms/show", type: :view do
  let(:user) { create(:user) }

  before(:each) do
    sign_in user
    assign(:health_symptom, create(:health_symptom, user: user))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Sintoma/)
    expect(rendered).to match(/Intensidade/)
  end
end
