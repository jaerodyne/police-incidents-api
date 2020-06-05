require 'rails_helper'

describe Api::V1::IncidentsController, type: :request do
  describe '#index' do
    it 'returns http success' do
      get '/api/v1/incidents'

      expect(response).to have_http_status(:success)
    end

    it 'returns an array of all incidents' do
      Incident.create(first_name: 'Very', last_name: 'Berry')
      Incident.create(first_name: 'Strawberry', last_name: 'Sunrise')

      get '/api/v1/incidents'

      expect(JSON.parse(response.body).length).to eq Incident.count
    end
  end

  describe '#show' do
    it 'retrieves a specific incident' do
      incident = Incident.create(first_name: 'Lemonade', last_name: 'Surprise')

      get "/api/v1/incidents/#{incident.id}"

      expect(JSON.parse(response.body)['id']).to eq incident.id
      expect(JSON.parse(response.body)['first_name']).to eq incident.first_name
      expect(JSON.parse(response.body)['last_name']).to eq incident.last_name
    end
  end
end
