require 'csv'
require 'progress_bar'

# washington post data
incident_data = 'lib/tasks/data/fatal-police-shootings-data.csv'
bar = ProgressBar.new

# TODO: find a more performant/non one-shot heavy operation
# Will probably have to load in data in batches
CSV.foreach(incident_data, headers: true) do |row|
  names = row['name'].split(' ')
  cause_of_death = row['manner_of_death'].split(' ').map(&:downcase).reject { |cause| cause == 'and' }

  Incident.create(
    first_name: names[0],
    last_name: names[1],
    age: row['age'].to_i,
    gender: row['gender'],
    race: row['race'],
    date: row['date'].to_datetime,
    city: row['city'],
    state: row['state'],
    cause_of_death: cause_of_death
  )

  bar.increment! 1
end
