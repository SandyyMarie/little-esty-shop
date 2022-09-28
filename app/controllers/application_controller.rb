class ApplicationController < ActionController::Base
  before_action :next_holidays

  private

  def next_holidays
    @holidays = HolidaySearch.next_holidays
  end
end
