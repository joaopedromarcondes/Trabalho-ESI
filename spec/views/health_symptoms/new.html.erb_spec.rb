require 'rails_helper'

RSpec.describe "health_symptoms/new", type: :view do
  let(:user) { create(:user) }

  before(:each) do
    sign_in user
    assign(:health_symptom, build(:health_symptom, user: user))
  end

  it "renders new health_symptom form" do
    render

    assert_select "form[action=?][method=?]", health_symptoms_path, "post" do

      assert_select "input[name=?]", "health_symptom[sintoma]"

      assert_select "select[name=?]", "health_symptom[intensidade]"
    end
  end
end
