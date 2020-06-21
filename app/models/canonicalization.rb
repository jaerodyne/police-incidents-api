class Canonicalization
  attr_reader :params

  RACE = {
    'W' => ['White, non-Hispanic', 'White'],
    'B' => ['Black'],
    'A' => ['Asian'],
    'N' => ['Native American'],
    'H' => ['Hispanic'],
    'O' => ['Other'],
    'P' => ['Pacific Islander'],
    'None' => ['Unknown', 'Unknown Race']
  }.freeze

  def initialize(params: {})
    @params = formatted_params(params)
  end

  private
  
  def formatted_params(params)
    formatted_values = {}
    params.map do |key, value|
      # Call method to override and reformat if key is defined
      formatted_values[key] = respond_to?(key, value) ? send(key, value) : value
    end
    formatted_values
  end
  
  def race(value)
    RACE.find { |key, values| return key if values.include?(value) }
  end
end