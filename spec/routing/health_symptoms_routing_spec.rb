require "rails_helper"

RSpec.describe HealthSymptomsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/health_symptoms").to route_to("health_symptoms#index")
    end

    it "routes to #new" do
      expect(get: "/health_symptoms/new").to route_to("health_symptoms#new")
    end

    it "routes to #show" do
      expect(get: "/health_symptoms/1").to route_to("health_symptoms#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/health_symptoms/1/edit").to route_to("health_symptoms#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/health_symptoms").to route_to("health_symptoms#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/health_symptoms/1").to route_to("health_symptoms#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/health_symptoms/1").to route_to("health_symptoms#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/health_symptoms/1").to route_to("health_symptoms#destroy", id: "1")
    end
  end
end
