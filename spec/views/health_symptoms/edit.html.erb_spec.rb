require 'rails_helper'

RSpec.describe "health_symptoms/edit", type: :view do
  let(:health_symptom) {
    HealthSymptom.create!(
      sintoma: "MyString",
      intensidade: 1
    )
  }

  before(:each) do
    assign(:health_symptom, health_symptom)
  end

  it "renders the edit health_symptom form" do
    render

    assert_select "form[action=?][method=?]", health_symptom_path(health_symptom), "post" do

      assert_select "input[name=?]", "health_symptom[sintoma]"

      assert_select "input[name=?]", "health_symptom[intensidade]"
    end
  end
end
