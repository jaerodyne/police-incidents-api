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

    context 'query params' do
      it 'filters by last name' do
        last_name = Incident.create(last_name: 'Wobble').last_name
        Incident.create(last_name: 'Yip')

        get "/api/v1/incidents?last_name=#{last_name}"

        expect(JSON.parse(response.body).map { |incident| incident['last_name'] }).to all eq(last_name)
      end

      it 'filters by age' do
        age = Incident.create(age: 42).age
        Incident.create(age: 36)

        get "/api/v1/incidents?age=#{age}"

        expect(JSON.parse(response.body).map { |incident| incident['age'] }).to all eq age
      end

      it 'filters by age range' do
        age1 = Incident.create(age: 43).age
        age2 = Incident.create(age: 50).age
        age3 = Incident.create(age: 22).age

        age_params = "#{age1},#{age2}"

        get "/api/v1/incidents?age=#{age_params}"

        expect(JSON.parse(response.body).map { |incident| incident['age'] }).to match_array ([age1, age2])
        expect(JSON.parse(response.body).map { |incident| incident['age'] }).to_not include age3
      end

      it 'filters by gender' do
        gender = Incident.create(gender: 'M').gender
        Incident.create(state: 'F')

        get "/api/v1/incidents?gender=#{gender}"

        expect(JSON.parse(response.body).map { |incident| incident['gender'] }).to all eq(gender)
      end

      it 'filters by race' do
        race = Incident.create(race: 'A').race
        Incident.create(race: 'W')

        get "/api/v1/incidents?race=#{race}"

        expect(JSON.parse(response.body).map { |incident| incident['race'] }).to all eq(race)
      end

      it 'filters by year' do
        year = Incident.create(date: Date.new(2020)).date.year
        Incident.create(date: Date.new(2015))

        get "/api/v1/incidents?year=#{year}"

        expect(JSON.parse(response.body).map { |incident| incident['date'].to_date.year }).to all eq(year)
      end

      it 'filters by city' do
        city = Incident.create(city: 'Minneapolis').city
        Incident.create(city: 'Chicago')

        get "/api/v1/incidents?city=#{city}"

        expect(JSON.parse(response.body).map { |incident| incident['city'] }).to all eq(city)
      end

      it 'filters by state' do
        state = Incident.create(state: 'MN').state
        Incident.create(state: 'IL')

        get "/api/v1/incidents?state=#{state}"

        expect(JSON.parse(response.body).map { |incident| incident['state'] }).to all eq(state)
      end

      it 'filters by cause of death' do
        cause_of_death = Incident.create(cause_of_death: ['shot', 'tasered']).cause_of_death
        Incident.create(cause_of_death: ['knife'])

        get "/api/v1/incidents?cause_of_death=#{cause_of_death}"

        expect(JSON.parse(response.body).map { |incident| incident['cause_of_death'] }).to all eq(cause_of_death)
      end
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
