require 'rails_helper'

RSpec.describe 'visiting the Discount Show Page' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    
    @items_1 = create_list(:item, 10, merchant: @merchant_1)
    @items_1 = create_list(:item, 20, merchant: @merchant_1)
    
    
    @discount_1 = create(:discount, merchant: @merchant_1)
    @discount_2 = create(:discount, merchant: @merchant_1)
    @discount_3 = create(:discount, merchant: @merchant_2)
  end
  # As a merchant
  # When I visit my bulk discount show page
  # Then I see the bulk discount's quantity threshold and percentage discount

  it 'shows the bulk discounts quantitity threshold and percentage discount' do
    visit merchant_discount_path(@merchant_1, @discount_1) #show

    expect(page).to have_content(@discount_1.discount_amount.round(2) * 100)
    expect(page).to have_content(@discount_1.threshold)
  end
end