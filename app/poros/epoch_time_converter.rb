class EpochTimeConverter
  def self.month(month_number)
    months = {
      1 => 'January',
      2 => 'February',
      3 => 'March',
      4 => 'April',
      5 => 'May',
      6 => 'June',
      7 => 'July',
      8 => 'August',
      9 => 'September',
      10 => 'October',
      11 => 'November',
      12 => 'December'
    }
    months[month_number]
  end

  def self.day(day_number)
    days = {
      1 => 'Monday',
      2 => 'Tuesday',
      3 => 'Wednesday',
      4 => 'Thursday',
      5 => 'Friday',
      6 => 'Saturday',
      7 => 'Sunday'}
    days[day_number]
  end

  attr_reader :epoch_time, :offset

  def initialize(epoch_time, offset)
    @epoch_time = epoch_time
    @offset = offset
  end
end
