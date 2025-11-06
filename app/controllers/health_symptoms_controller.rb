class HealthSymptomsController < ApplicationController
  before_action :set_health_symptom, only: %i[ show edit update destroy ]

  # GET /health_symptoms or /health_symptoms.json
  def index
    @health_symptoms = HealthSymptom.all
  end

  # GET /health_symptoms/1 or /health_symptoms/1.json
  def show
  end

  # GET /health_symptoms/new
  def new
    @health_symptom = HealthSymptom.new
  end

  # GET /health_symptoms/1/edit
  def edit
  end

  # POST /health_symptoms or /health_symptoms.json
  def create
    @health_symptom = HealthSymptom.new(health_symptom_params)

    respond_to do |format|
      if @health_symptom.save
        format.html { redirect_to @health_symptom, notice: "Sintoma registrado com sucesso." }
        format.json { render :show, status: :created, location: @health_symptom }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @health_symptom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /health_symptoms/1 or /health_symptoms/1.json
  def update
    respond_to do |format|
      if @health_symptom.update(health_symptom_params)
        format.html { redirect_to @health_symptom, notice: "Sintoma atualizado com sucesso.", status: :see_other }
        format.json { render :show, status: :ok, location: @health_symptom }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @health_symptom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /health_symptoms/1 or /health_symptoms/1.json
  def destroy
    @health_symptom.destroy!

    respond_to do |format|
      format.html { redirect_to health_symptoms_path, notice: "Sintoma destruído com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_health_symptom
      @health_symptom = HealthSymptom.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def health_symptom_params
      params.expect(health_symptom: [ :sintoma, :intensidade ])
    end
end
