module Users
  class ActivityController < ApplicationController
    before_action :authenticate_user!

    def index
      @user = current_user
      @audio_submissions = @user.audio_submissions.order(created_at: :desc)
      @photos = @user.photos.order(created_at: :desc)
      @noise_measurements = @user.noise_measurements.order(created_at: :desc)
    end
  end
end
