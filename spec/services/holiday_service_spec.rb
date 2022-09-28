require 'rails_helper'

RSpec.describe HolidayService do
  it 'can get all repos' do
    allow(HolidayService).to receive(:get_next_3_holidays).and_return([{name: "Indigenous Peoples Day", date: '10/10/2022'}])
    data = HolidayService.get_next_3_holidays
    expect(data).to be_an(Array)
    expect(data[0]).to be_an(Hash)
    expect(data[0]).to have_key(:name)
    expect(data[0]).to have_key(:date)
  end

end
