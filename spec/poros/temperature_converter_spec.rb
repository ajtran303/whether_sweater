require 'rails_helper'

RSpec.describe TemperatureConverter do
  it 'can convert Kelvin to Fahrenheit' do
    kelvin = 299.7
    fahrenheit = 79.79
    expect(TemperatureConverter.kelvin_to_fahrenheit(kelvin)).to eq(fahrenheit)
  end

  it 'can convert any Kelvin to Fahrenheit' do
    kelvin = 1000
    fahrenheit = 1340.33
    expect(TemperatureConverter.kelvin_to_fahrenheit(kelvin)).to eq(fahrenheit)
  end

  it 'can convert ANY Kelvin to Fahrenheit' do
    kelvin = 0
    fahrenheit = -459.67
    expect(TemperatureConverter.kelvin_to_fahrenheit(kelvin)).to eq(fahrenheit)
  end
end
