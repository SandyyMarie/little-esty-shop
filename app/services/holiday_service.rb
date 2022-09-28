require 'httparty'
require 'json'

class HolidayService

  def self.get_next_holidays
    # return [{name: 'Indigenous Peoples Day(TEST)', date: '10/10/2022'}, {name: 'Veterans Day(TEST)', date: '11/11/2022'}, {name: 'Thanksgiving(TEST)', date: '11/24/2022'}] if Rails.env == 'test'
    get_uri('https://date.nager.at/api/v3/NextPublicHolidays/us')
  end

  def self.get_uri(uri)
    data = HTTParty.get(uri)
    parsed = JSON.parse(data.body, symbolize_names: true)
  end
end
