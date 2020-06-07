require 'csv'
require 'progress_bar'

# washington post data
washington_post_incident_data = 'lib/tasks/data/fatal-police-shootings-data.csv'
csv_rows_count = CSV.foreach(washington_post_incident_data, headers: true).count
washington_post_incident_data_progress = ProgressBar.new(csv_rows_count)

# TODO: find a more performant/non one-shot heavy operation
# Will probably have to load in data in batches
CSV.foreach(washington_post_incident_data, headers: true) do |row|
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
    cause_of_death: cause_of_death,
    source_name: 'washington_post'
  )

  washington_post_incident_data_progress.increment!
end

# Mapping police violence.org data
mpv_incident_data = 'lib/tasks/data/MPVDatasetDownload.xlsx'
xlsx = Roo::Spreadsheet.open(mpv_incident_data)
mpv_incident_data_progress = ProgressBar.new(xlsx.count)

# The first sheet in the excel file holds all police data from 2013-2019
xlsx.sheet(0).parse(headers: true) do |row|
  names = row["Victim's name"]&.split(' ')
  # Get every name except last name in array
  first_name = names.take(names.length - 1).join(' ')
  last_name = names.last

  Incident.create(
    first_name: first_name,
    last_name: last_name,
    age: row["Victim's age"],
    gender: row["Victim's gender"],
    race: row["Victim's race"],
    date: row["Date of Incident (month/day/year)"].to_datetime,
    city: row["City"],
    state: row["State"],
    cause_of_death: row["Cause of death"]&.downcase,
    source_name: 'mapping_police_violence'
  )

  mpv_incident_data_progress.increment!
end
