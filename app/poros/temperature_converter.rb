class TemperatureConverter
  def self.kelvin_to_fahrenheit kelvin
    fahrenheit = (kelvin - 273.15) * 9/5 + 32
    fahrenheit.round 2
  end
end
