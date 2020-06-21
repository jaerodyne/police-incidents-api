class Canonicalization
  attr_reader :params

  CAUSE_OF_DEATH = {
    'asphyxiated' => ['asphyxiated'],
    'baton' => ['baton'],
    'bean_bag' => ['bean bag'],
    'beaten' => ['beaten'],
    'bludgeoned' => ['bludgeoned with instrument'],
    'bomb' => ['bomb'],
    'other' => ['other'],
    'pepper_spray' => ['pepper spray'],
    'physical_restraint' => ['physical restraint'],
    'police_dog' => ['police dog'],
    'shot' => ['gunshot', 'shot'],
    'stabbed' => ['stabbed'],
    'tasered' => ['taser', 'tasered'],
    'unspecified_less_lethal_weapon' => ['unspecified less lethal weapon'],
    'vehicle' => ['vehicle']
  }.freeze

  GENDER = {
    'M' => 'Male',
    'F' => 'Female',
    'None' => 'Unknown'
  }.freeze

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

  def cause_of_death(value)
    return value unless value.length > 1

    value.map do |cause|
      CAUSE_OF_DEATH.each do |cod, cods|
        return cod if cods.include?(cause)
      end
    end
  end

  def gender(value)
    GENDER.key(value)
  end
  
  def race(value)
    RACE.find { |key, values| values.include?(value) }&.first
  end
end