require 'rails_helper'

RSpec.describe 'Epoch Time Converter' do

  describe 'Class Methods' do
    it 'knows the date_time' do
      epoch_time = 1600641959
      offset = -21600
      date_time = EpochTimeConverter.date_time(epoch_time, offset)
      expect(date_time).to eq 'September 20 2020 4:45 PM Sunday'
  end

    it 'knows names of the months' do
      expect(EpochTimeConverter.month(1)).to eq 'January'
      expect(EpochTimeConverter.month(2)).to eq 'February'
      expect(EpochTimeConverter.month(3)).to eq 'March'
      expect(EpochTimeConverter.month(4)).to eq 'April'
      expect(EpochTimeConverter.month(5)).to eq 'May'
      expect(EpochTimeConverter.month(6)).to eq 'June'
      expect(EpochTimeConverter.month(7)).to eq 'July'
      expect(EpochTimeConverter.month(8)).to eq 'August'
      expect(EpochTimeConverter.month(9)).to eq 'September'
      expect(EpochTimeConverter.month(10)).to eq 'October'
      expect(EpochTimeConverter.month(11)).to eq 'November'
      expect(EpochTimeConverter.month(12)).to eq 'December'
    end

    it 'knows names of days of the calendar' do
      expect(EpochTimeConverter.day(1)).to eq 'Monday'
      expect(EpochTimeConverter.day(2)).to eq 'Tuesday'
      expect(EpochTimeConverter.day(3)).to eq 'Wednesday'
      expect(EpochTimeConverter.day(4)).to eq 'Thursday'
      expect(EpochTimeConverter.day(5)).to eq 'Friday'
      expect(EpochTimeConverter.day(6)).to eq 'Saturday'
      expect(EpochTimeConverter.day(7)).to eq 'Sunday'
    end
  end

  describe 'Instance Methods' do
    before :each do
      @epoch_time = 1600641959
      @offset = -21600
      @date_time = EpochTimeConverter.new(@epoch_time, @offset)
    end

    it 'exists' do
      expect(@date_time).to be_a(EpochTimeConverter)
    end

    it 'has attributes' do
      expect(@date_time.local_epoch_time).to eq @epoch_time + @offset
    end

    it 'can tell date and time' do
      expect(@date_time.month).to eq 'September'
      expect(@date_time.day_of_week).to eq 'Sunday'
      expect(@date_time.day_of_month).to eq '20'
      expect(@date_time.year).to eq '2020'
      expect(@date_time.hour).to eq '4'
      expect(@date_time.minute).to eq '45'
      expect(@date_time.meridiem).to eq 'PM'
    end

    it 'can tell another date and time' do
      another_date_time = EpochTimeConverter.new(1600668864, @offset)
      expect(another_date_time.month).to eq 'September'
      expect(another_date_time.day_of_week).to eq 'Monday'
      expect(another_date_time.day_of_month).to eq '21'
      expect(another_date_time.year).to eq '2020'
      expect(another_date_time.hour).to eq '12'
      expect(another_date_time.minute).to eq '14'
      expect(another_date_time.meridiem).to eq 'AM'
    end
  end
end
