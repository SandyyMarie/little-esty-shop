require 'rails_helper'

RSpec.describe 'Discount Index Page' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @items_1 = create_list(:item, 10, merchant: @merchant_1)
    @items_1 = create_list(:item, 20, merchant: @merchant_1)


    @discount_1 = create(:discount, merchant: @merchant_1)
    @discount_2 = create(:discount, merchant: @merchant_1)
    # @discount_3 = create(:discount, merchant: @merchant_2)
  end
      # Merchant Bulk Discounts Index

      # As a merchant
      # When I visit my merchant dashboard
      # Then I see a link to view all my discounts
      # When I click this link

      # Then I am taken to my bulk discounts index page
      # Where I see all of my bulk discounts including their
      # percentage discount and quantity thresholds
      # And each bulk discount listed includes a link to its show page

  it 'I see a link to view all my discounts, that takes me to my bulk index page - with all bulk discounts their % discount and quantity threshold, with a link to its show page' do
    visit merchant_dashboard_path(@merchant_1)

    click_link "View all discounts"

    expect(current_path).to eq(merchant_discounts_path(@merchant_1)) #discount index
    expect(page).to have_content(@discount_1.discount_amount.round(2) * 100)
    expect(page).to have_content(@discount_1.threshold)
    
    save_and_open_page
    click_link "Discount Description"
    expect(current_path).to eq(merchant_discount_path(@discount_1)) #discount show
  end
end