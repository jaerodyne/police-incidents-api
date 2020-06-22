module Api
  module V1
    class IncidentsController < ApplicationController
      before_action :set_incident, only: :show

      PERMITTED_INCIDENT_PARAMS = %i[
        last_name
        age
        gender
        race
        year
        city
        state
        cause_of_death
      ].freeze

      def index
        @incidents = Incident.where(nil)

        filtering_incident_params.each do |key, value|
          @incidents = @incidents.public_send("filter_by_#{key}", value) if value.present?
        end

        render json: @incidents
      end

      def show
        render json: @incident
      end

      def sources
        render json: Incident.pluck(:source_name).uniq
      end

      private
      
      def set_incident
        @incident = Incident.find(params[:id])
      end

      def filtering_incident_params
        params.permit(PERMITTED_INCIDENT_PARAMS)
      end
    end
  end
end