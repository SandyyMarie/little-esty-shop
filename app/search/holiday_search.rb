class HolidaySearch
  def self.next_holidays 
    repo_data ||= HolidayService.get_next_holidays
    repo_data[0..2].map do |holiday|
      Holiday.new(holiday)
    end
  end
end
