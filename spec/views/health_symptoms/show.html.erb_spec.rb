require 'rails_helper'

RSpec.describe "health_symptoms/show", type: :view do
  before(:each) do
    assign(:health_symptom, HealthSymptom.create!(
      sintoma: "Sintoma",
      intensidade: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Sintoma/)
    expect(rendered).to match(/2/)
  end
end
