require 'rails_helper'

RSpec.describe 'visiting the Discount Edit Page' do
  before :each do
    @merchant_1 = create(:merchant)

    @discount_1 = create(:discount, merchant: @merchant_1)
    @discount_2 = create(:discount, merchant: @merchant_1)
  end

  it 'the show page has a link to edit the bulk discount, when clicked you go to new page with form to edit, with prepopulated areas in the form (US#5)' do 
    visit merchant_discount_path(@merchant_1, @discount_2)

    click_link "Edit this Discount"
    save_and_open_page
    expect(current_path).to eq(edit_merchant_discount_path(@merchant_1, @discount_2))
    expect(page).to have_content(@discount_2.discount_amount.round(2) * 100)
    expect(page).to have_content(@discount_2.threshold)
  end

  it 'when edit button is clicked and youre taken to a new page with a form, i can update info and click submit and see changes after redirection to show page (US#5)' do
    visit merchant_discount_path(@merchant_1, @discount_2)

    holding_variable = @discount_2.discount_amount.round(2) * 100

    click_link "Edit this Discount"

    fill_in "New Discount Amount:", with: (@discount_2.discount_amount.round(2) + 0.10)
    fill_in "New Threshold Quantity:", with: (@discount_2.threshold + 5)

    click_button("Save updated discount")

    expect(current_path).to eq(visit merchant_discount_path(@merchant_1, @discount_2))
    expect(page).to have_content(@discount_2.discount_amount.round(2) * 100)
    expect(page).to have_content(@discount_2.threshold)

    expect(holding_variable).to_not eq(@discount_2.discount_amount.round(2) * 100) #may not work, trying to ensure the amount does in fact change
  end

end