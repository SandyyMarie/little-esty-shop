require 'rails_helper'

RSpec.describe 'visiting the Discount Index Page' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @items_1 = create_list(:item, 10, merchant: @merchant_1)
    @items_1 = create_list(:item, 20, merchant: @merchant_1)


    @discount_1 = create(:discount, merchant: @merchant_1)
    @discount_2 = create(:discount, merchant: @merchant_1)
  end

  it 'From dashboard I see a link to view all my discounts, that takes me to my bulk index page - with all bulk discounts their % discount and quantity threshold, with a link to its show page (US#1)' do
    visit merchant_dashboard_path(@merchant_1)

    click_link "View all discounts"

    expect(current_path).to eq(merchant_discounts_path(@merchant_1)) #discount index
    expect(page).to have_content(@discount_1.discount_amount.round(2) * 100)
    expect(page).to have_content(@discount_1.threshold)
    
    within "#discount-#{@discount_1.id}" do
      click_link "Discount Description"
      expect(current_path).to eq(merchant_discount_path(@merchant_1, @discount_1)) #discount show
    end
  end

  it 'when visiting discount index page I see a link to create a new discount, which takes me to a new page (US#2)' do
    visit merchant_discounts_path(@merchant_1) #discount index

    click_link "Create new discount"

    expect(current_path).to eq(new_merchant_discount_path(@merchant_1))
  end

  it 'the new page from the new discount has a form that you fill with valid data and then are redirected back to discount#index and see new discount listed (US#2)' do
    visit new_merchant_discount_path(@merchant_1) #discount new
    fill_in "Discount Amount:", with: 0.25
    fill_in "Threshold Quantity:", with: 17
    click_button "Save new discount"

    expect(current_path).to eq(merchant_discounts_path(@merchant_1))
    expect(page).to have_content("Discount Amount: 25.0%")
    expect(page).to have_content("Threshold Quantity: 17")
  end

  it 'shows a link to delete each bulk discount next to it, when you click link you return to #index and the deleted discount is removed (US#3)' do
    visit merchant_discounts_path(@merchant_1)
    expect(page).to have_content(@discount_1.discount_amount.round(2) * 100)
    expect(page).to have_content(@discount_1.threshold)

    within "#discount-#{@discount_1.id}" do
      click_link "Delete this Discount"
    end
    
    expect(current_path).to eq(merchant_discounts_path(@merchant_1))

    within "#index-info" do
      expect(page).to_not have_content(@discount_1.discount_amount.round(2) * 100)
      expect(page).to_not have_content(@discount_1.threshold)
    end
  end

#   As a merchant
# When I visit the discounts index page
# I see a section with a header of "Upcoming Holidays"
# In this section the name and date of the next 3 upcoming US holidays are listed.

# Use the Next Public Holidays Endpoint in the [Nager.Date API](https://date.nager.at/swagger/index.html)
  it 'shows a section with a header for Upcoming Holidays, with the name and date of the next 3 upcoming US holidays listed (US#8)' do
    merchant_discounts_path(@merchant_1)

    expect(page).to have_content("Columbus Day")
    expect(page).to have_content("Veterans Day")
    expect(page).to have_content("Thanksgiving")
  end
end