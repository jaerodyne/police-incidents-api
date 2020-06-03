require 'rails_helper'

describe Incident, type: :model do
  describe '#full_name' do
    it 'returns a first name and a last name' do
      incident = Incident.new(first_name: 'Very', last_name: 'Berry')
      expect(incident.full_name).to include incident.first_name
      expect(incident.full_name).to include incident.last_name
    end
  end
end