class Incident < ApplicationRecord
  scope :filter_by_last_name, -> (last_name) { where last_name: last_name }
  scope :filter_by_age, -> (age) { where age: age }
  scope :filter_by_gender, -> (gender) { where gender: gender }
  scope :filter_by_race, -> (race) { where race: race }
  scope :filter_by_year, -> (year) { where date: date_range(year) }
  scope :filter_by_city, -> (city) { where city: city }
  scope :filter_by_state, -> (state) { where state: state.upcase }
  scope :filter_by_cause_of_death, -> (cause_of_death) { 
    where("cause_of_death @> ?", cause_of_death.split(',').to_json)
  }

  validate :cause_of_death_is_array

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  class << self
    def date_range(year)
      date = Date.today.change(year: year.to_i)
  
      [date.beginning_of_year..date.end_of_year]
    end
  end

  def cause_of_death_is_array
    errors.add(:cause_of_death, "must be an array") unless cause_of_death.kind_of?(Array)
  end
end
