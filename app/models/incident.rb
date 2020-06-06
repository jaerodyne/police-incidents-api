class Incident < ApplicationRecord
  scope :filter_by_last_name, -> (last_name) { where last_name: last_name }
  scope :filter_by_age, -> (age) { where age: age }
  scope :filter_by_gender, -> (gender) { where gender: gender }
  scope :filter_by_race, -> (race) { where race: race }
  scope :filter_by_year, -> (year) { where date: date_range(year) }
  scope :filter_by_city, -> (city) { where city: city }
  scope :filter_by_state, -> (state) { where state: state }
  scope :filter_by_cause_of_death, -> (cause_of_death) { 
    where("cause_of_death @> ?", [cause_of_death].to_json)
  }

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def self.date_range(year)
    date = Date.today.change(year: year.to_i)

    [date.beginning_of_year..date.end_of_year]
  end
end
