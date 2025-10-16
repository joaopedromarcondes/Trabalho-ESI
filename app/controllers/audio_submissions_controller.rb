class AudioSubmissionsController < ApplicationController
  def new
    @audio_submission = AudioSubmission.new
  end

  def create
    @audio_submission = AudioSubmission.new(audio_submission_params)

    if @audio_submission.valid?
      redirect_to root_path, notice: 'Áudio enviado com sucesso'
    else
      flash.now[:alert] = @audio_submission.errors.full_messages.to_sentence
      render :new, status: :unprocessable_content
    end
  end

  private

  def audio_submission_params
    permitted = params.require(:audio_submission).permit(:latitude, :longitude, :duration_seconds)
    permitted[:audio_attached] = params.dig(:audio_submission, :audio).present?
    permitted
  end
end
