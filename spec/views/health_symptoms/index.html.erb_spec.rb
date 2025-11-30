require 'rails_helper'

RSpec.describe "health_symptoms/index", type: :view do
  let(:user) { create(:user) }

  before(:each) do
    sign_in user
    assign(:health_symptoms, [
      create(:health_symptom, user: user),
      create(:health_symptom, user: user)
    ])
  end

  it "renders a list of health_symptoms" do
    render
    cell_selector = 'p'
    assert_select cell_selector, text: Regexp.new("Sintoma".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Intensidade".to_s), count: 2
  end
end
