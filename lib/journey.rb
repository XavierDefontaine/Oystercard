class Journey
  attr_reader :entry_station, :exit_station
  def initialize
    @entry_station = nil
    @exit_station = nil 
  end

  def start(entry_station)
    @entry_station = entry_station
  end

  def end(exit_station)
    @exit_station = exit_station
    { entry_station: @entry_station, exit_station: @exit_station }
  end

  def in_journey?
    !!@entry_station
  end

end