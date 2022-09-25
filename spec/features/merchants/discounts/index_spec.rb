require 'rails_helper'

RSpec.describe 'Discount Index Page' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @pretty_plumbing = create(:merchant)

    @items_1 = create_list(:item, 6, merchant: @pretty_plumbing)
    @items_2 = create_list(:item, 6, merchant: @merchant_2)

    @customers_1 = create_list(:customer, 10)
    @customers_2 = create_list(:customer, 10)

    @invoice_1 = create(:invoice, customer: @customers_1[0], created_at: "08-10-2022")
    @invoice_2 = create(:invoice, customer: @customers_1[1], created_at: "09-10-2022")
    @invoice_3 = create(:invoice, customer: @customers_1[2], created_at: "10-08-2022")
    @invoice_4 = create(:invoice, customer: @customers_1[3], created_at: "10-06-2022")
    @invoice_5 = create(:invoice, customer: @customers_1[4], created_at: "10-10-2022")
    @invoice_6 = create(:invoice, customer: @customers_1[5], created_at: "01-07-2022")
    @invoice_7 = create(:invoice, customer: @customers_1[6], created_at: "10-09-2022")
    @invoice_8 = create(:invoice, customer: @customers_1[7], created_at: "10-11-2022")

    @invoice_9 = create(:invoice, customer: @customers_2[0], created_at: "08-10-2020")
    @invoice_10 = create(:invoice, customer: @customers_2[1], created_at: "09-10-2021")
    @invoice_11 = create(:invoice, customer: @customers_2[2], created_at: "10-08-2010")
    @invoice_12 = create(:invoice, customer: @customers_2[3], created_at: "10-06-2001")
    @invoice_13 = create(:invoice, customer: @customers_2[4], created_at: "10-10-2021")
    @invoice_14 = create(:invoice, customer: @customers_2[5], created_at: "01-07-2002")
    @invoice_15 = create(:invoice, customer: @customers_2[6], created_at: "26-09-2015")
    @invoice_16 = create(:invoice, customer: @customers_2[7], created_at: "10-12-2022")

    # customers_1[0] transactions
    @transactions_1 = create_list(:transaction, 3, invoice: @invoice_1, result: :failed)
    @transactions_2 = create_list(:transaction, 5, invoice: @invoice_1, result: :success)
    # customers_1[1] transactions
    @transactions_3 = create_list(:transaction, 1, invoice: @invoice_2, result: :failed)
    @transactions_4 = create_list(:transaction, 7, invoice: @invoice_2, result: :success)
    # customers_1[2] transactions
    @transactions_5 = create_list(:transaction, 2, invoice: @invoice_3, result: :failed)
    @transactions_6 = create_list(:transaction, 6, invoice: @invoice_3, result: :success)
    # customers_1[3] transactions
    @transactions_7 = create_list(:transaction, 8, invoice: @invoice_4, result: :success)
    # customers_1[4] transactions
    @transactions_8 = create_list(:transaction, 4, invoice: @invoice_5, result: :failed)
    # customers_1[5] transactions
    @transactions_9 = create_list(:transaction, 2, invoice: @invoice_6, result: :failed)
    @transactions_10 = create_list(:transaction, 2, invoice: @invoice_6, result: :success)
    # customers_1[6] transactions
    @transactions_11 = create_list(:transaction, 3, invoice: @invoice_7, result: :failed)
    @transactions_12 = create_list(:transaction, 1, invoice: @invoice_7, result: :success)
    # customers_1[7] transactions
    @transactions_13 = create_list(:transaction, 4, invoice: @invoice_8, result: :success)

    # customers_2[0] transactions
    @transactions_14 = create_list(:transaction, 3, invoice: @invoice_9, result: :failed)
    @transactions_15 = create_list(:transaction, 5, invoice: @invoice_9, result: :success)
    # customers_2[1] transactions
    @transactions_16 = create_list(:transaction, 1, invoice: @invoice_10, result: :failed)
    @transactions_17 = create_list(:transaction, 7, invoice: @invoice_10, result: :success)
    # customers_2[2] transactions
    @transactions_18 = create_list(:transaction, 2, invoice: @invoice_11, result: :failed)
    @transactions_19 = create_list(:transaction, 6, invoice: @invoice_11, result: :success)
    # customers_2[3] transactions
    @transactions_20 = create_list(:transaction, 8, invoice: @invoice_12, result: :success)
    # customers_2[4] transactions
    @transactions_21 = create_list(:transaction, 4, invoice: @invoice_13, result: :failed)
    # customers_2[5] transactions
    @transactions_22 = create_list(:transaction, 2, invoice: @invoice_14, result: :failed)
    @transactions_23 = create_list(:transaction, 2, invoice: @invoice_14, result: :success)
    # customers_2[6] transactions
    @transactions_24 = create_list(:transaction, 3, invoice: @invoice_15, result: :failed)
    @transactions_25 = create_list(:transaction, 1, invoice: @invoice_15, result: :success)
    # customers_2[7] transactions
    @transactions_26 = create_list(:transaction, 4, invoice: @invoice_16, result: :success)

    @discount1 = create(:discount, merchant: @pretty_plumbing)
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
    visit merchant_dashboard_path(@pretty_plumbing)

    click_link "View all discounts"

    expect(current_path).to eq(merchant_discount_path(@pretty_plumbing))
    expect(page).to have_content(bulk_discounts_placeholder)

    click_link "z Discount"
    expect(current_path).to eq(merchant_discount_show(item))
  end
end