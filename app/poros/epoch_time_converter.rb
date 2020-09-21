class EpochTimeConverter
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

  attr_reader :local_epoch_time

  def initialize(epoch_time, offset)
    @local_epoch_time = epoch_time + offset
  end

  def month
    self.class.month date_time.month
  end

  def day_of_week
    self.class.day date_time.cwday
  end

  def day_of_month
    date_time.day.to_s
  end

  def hour
    (date_time.hour - 12).abs.to_s
  end

  def minute
    date_time.minute.to_s
  end

  def meridiem
    date_time.hour >= 12 ? 'PM' : 'AM'
  end

  private

  def date_time
    @date_time ||= DateTime.strptime((local_epoch_time ).to_s, '%s')
  end
end
