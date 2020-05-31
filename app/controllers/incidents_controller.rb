class IncidentsController < ApplicationController
  before_action :set_incident, only: :show

  # GET /incidents
  def index
    @incidents = Incident.all

    render json: @incidents
  end

  # GET /incidents/1
  def show
    render json: @incident
  end

  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_incident
    @incident = Incident.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def incident_params
    params.fetch(:incident, {})
  end
end
