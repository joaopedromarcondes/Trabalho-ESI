require 'rails_helper'

RSpec.describe "health_symptoms/new", type: :view do
  before(:each) do
    assign(:health_symptom, HealthSymptom.new(
      sintoma: "MyString",
      intensidade: 1
    ))
  end

  it "renders new health_symptom form" do
    render

    assert_select "form[action=?][method=?]", health_symptoms_path, "post" do

      assert_select "input[name=?]", "health_symptom[sintoma]"

      assert_select "input[name=?]", "health_symptom[intensidade]"
    end
  end
end
