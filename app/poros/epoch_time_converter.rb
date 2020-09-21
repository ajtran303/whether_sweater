class EpochTimeConverter
  def self.date_time(seconds_since_epoch, offset_seconds)
    date_time = new(seconds_since_epoch, offset_seconds)
    "#{date_time.month} " +
    "#{date_time.day_of_month} " +
    "#{date_time.year} " +
    "#{date_time.hour}:#{date_time.minute} #{date_time.meridiem} " +
    "#{date_time.day_of_week}"
  end

  def self.month(month_number)
    months = {
      1 => 'January', 2 => 'February', 3 => 'March', 4 => 'April',
      5 => 'May', 6 => 'June', 7 => 'July', 8 => 'August',
      9 => 'September', 10 => 'October', 11 => 'November', 12 => 'December'
    }
    months[month_number]
  end

  def self.day(day_number)
    days = {
      1 => 'Monday', 2 => 'Tuesday', 3 => 'Wednesday',
      4 => 'Thursday', 5 => 'Friday', 6 => 'Saturday',
      7 => 'Sunday'
    }
    days[day_number]
  end

  attr_reader :local_epoch_time,
              :month,
              :day_of_week,
              :day_of_month,
              :hour,
              :minute,
              :meridiem,
              :year

  def initialize(epoch_time, offset)
    @local_epoch_time = epoch_time + offset
    @month = self.class.month date_time.month
    @day_of_week = self.class.day date_time.cwday
    @day_of_month = date_time.day.to_s
    @hour = (date_time.hour - 12).abs.to_s
    @minute = date_time.minute.to_s
    @meridiem = date_time.hour >= 12 ? 'PM' : 'AM'
    @year = date_time.year.to_s
  end

  private

  def date_time
    @date_time ||= DateTime.strptime local_epoch_time.to_s, '%s'
  end
end
