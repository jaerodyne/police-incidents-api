class Canonicalization
  attr_reader :params

  CAUSE_OF_DEATH = {
    'asphyxiated' => ['asphyxiated'],
    'baton' => ['baton'],
    'bean_bag' => ['bean bag', 'beanbag', 'beanbag_gun', 'bean_bag_gun', 'beanbag_shot_gun', 'beanbag_shotgun'],
    'beaten' => ['beaten'],
    'bludgeoned' => ['bludgeoned_with_instrument'],
    'bomb' => ['bomb'],
    'other' => ['other'],
    'pepper_spray' => ['pepper_spray', 'pepper spray'],
    'physical_restraint' => ['physical_restraint', 'physical restraint'],
    'police_dog' => ['police_dog'],
    'shot' => ['gunshot', 'shot'],
    'stabbed' => ['stabbed'],
    'tasered' => ['taser', 'tasered'],
    'unspecified_less_lethal_weapon' => ['unspecified_less_lethal_weapon'],
    'vehicle' => ['vehicle']
  }.freeze

  GENDER = {
    'M' => 'Male',
    'F' => 'Female'
  }.freeze

  RACE = {
    'W' => ['White, non-Hispanic', 'White'],
    'B' => ['Black'],
    'A' => ['Asian'],
    'N' => ['Native American'],
    'H' => ['Hispanic'],
    'O' => ['Other'],
    'P' => ['Pacific Islander']
  }.freeze

  def initialize(params: {})
    @params = formatted_params(params)
  end

  private
  
  def formatted_params(params)
    formatted_values = {}
    params.map do |key, value|
      # Call method to override attribute and reformat if defined
      formatted_values[key] = respond_to?(key, value) ? send(key, value) : value
    end
    formatted_values
  end

  def cause_of_death(value)
    value.map! do |cause|
      CAUSE_OF_DEATH.find { |cod, cods|  cods.include?(cause) }&.first
    end.compact
  end

  def gender(value)
    GENDER.key(value)
  end
  
  def race(value)
    RACE.find { |key, values| values.include?(value) }&.first
  end
end