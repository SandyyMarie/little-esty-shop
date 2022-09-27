require 'rails_helper'

RSpec.describe 'visiting the Discount Show Page' do
  before :each do
    @merchant_1 = create(:merchant)

    @discount_1 = create(:discount, merchant: @merchant_1)
    @discount_2 = create(:discount, merchant: @merchant_1)
  end

  it 'shows the bulk discounts quantitity threshold and percentage discount (US#4)' do
    visit merchant_discount_path(@merchant_1, @discount_2) #show

    expect(page).to have_content(@discount_2.discount_amount.round(2) * 100)
    expect(page).to have_content(@discount_2.threshold)
  end
# As a merchant
# When I visit my bulk discount show page
# Then I see a link to edit the bulk discount
# When I click this link
# Then I am taken to a new page with a form to edit the discount
# And I see that the discounts current attributes are pre-poluated in the form
# When I change any/all of the information and click submit
# Then I am redirected to the bulk discount's show page
# And I see that the discount's attributes have been updated

  it 'has a link to edit the bulk discount, when clicked you go to new page with form to edit, with prepopulated areas in the form (US#5)' do 
    visit merchant_discount_path(@merchant_1, @discount_2)

    click_link "edit this discount"

    expect(current_path).to eq(edit_merchant_discount(@merchant_1, @discount_2))
    expect(page).to have_content(@discount_2.discount_amount.round(2) * 100)
    expect(page).to have_content(@discount_2.threshold)
  end

  it 'when edit button is clicked and youre taken to a new page with a form, i can update info and click submit and see changes after redirection to show page (US#5)' do
    visit merchant_discount_path(@merchant_1, @discount_2)
    holding_variable = @discount_2.discount_amount.round(2) * 100
    click_link "edit this discount"
    require 'pry'; binding.pry
    fill_in "New Discount Amount:", with: (@discount_2.discount_amount.round(2) + 0.10)
    fill_in "New Threshold Amount:", with: (@discount_2.threshold + 5)

    click_button('Submit')

    expect(current_path).to eq(visit merchant_discount_path(@merchant_1, @discount_2))
    expect(page).to have_content(@discount_2.discount_amount.round(2) * 100)
    expect(page).to have_content(@discount_2.threshold)

    expect(holding_variable).to_not eq(@discount_2.discount_amount.round(2) * 100) #may not work, trying to ensure the amount does in fact change
  end
end