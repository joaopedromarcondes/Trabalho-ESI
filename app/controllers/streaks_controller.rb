class StreaksController < ApplicationController
  before_action :authenticate_user!

  def index
    @streaks = current_user.todas_as_sequencias
  end
end
