require 'rails_helper'

RSpec.describe "health_symptoms/index", type: :view do
  before(:each) do
    assign(:health_symptoms, [
      HealthSymptom.create!(
        sintoma: "Sintoma",
        intensidade: 2
      ),
      HealthSymptom.create!(
        sintoma: "Sintoma",
        intensidade: 2
      )
    ])
  end

  it "renders a list of health_symptoms" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Sintoma".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end
