require 'rails_helper'

RSpec.describe 'visiting the Discount Show Page' do
  before :each do
    @merchant_1 = create(:merchant)

    @discount_1 = create(:discount, merchant: @merchant_1)
    @discount_2 = create(:discount, merchant: @merchant_1)
  end
  # As a merchant
  # When I visit my bulk discount show page
  # Then I see the bulk discount's quantity threshold and percentage discount

  it 'shows the bulk discounts quantitity threshold and percentage discount (US#4)' do
    visit merchant_discount_path(@merchant_1, @discount_2) #show

    expect(page).to have_content(@discount_2.discount_amount.round(2) * 100)
    expect(page).to have_content(@discount_2.threshold)
  end
end