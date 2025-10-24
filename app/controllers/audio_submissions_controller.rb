class AudioSubmissionsController < ApplicationController
  def new
    @audio_submission = AudioSubmission.new
  end

  def create
    @audio_submission = AudioSubmission.new(audio_submission_params)
    @audio_submission.user = current_user

    if @audio_submission.valid?
      @audio_submission.save
      @audio_submission.audio.attach(params[:audio_submission][:audio])
      redirect_to root_path, notice: 'Áudio enviado com sucesso'
    else
      flash.now[:alert] = @audio_submission.errors.full_messages.to_sentence
      render :new, status: :unprocessable_content
    end
  end

  private

  def audio_submission_params
    params.require(:audio_submission).permit(:latitude, :longitude, :duration_seconds, :audio)
  end
end
