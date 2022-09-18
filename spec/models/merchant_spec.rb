require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'Class Methods' do
    before :each do
      @merchant_1 = Merchant.create!(name: "Johns Tools", active_status: :enabled)
      @merchant_2 = Merchant.create!(name: "Hannas Hammocks", active_status: :enabled)
      @merchant_3 = Merchant.create!(name: "Pretty Plumbing")
      @merchant_4 = Merchant.create!(name: "Jenna's Jewlery", active_status: :enabled)
      @merchant_5 = Merchant.create!(name: "Sassy Soap")
      @merchant_6 = Merchant.create!(name: "Tom's Typewriters")
    end

    it "#active" do
      expect(Merchant.active).to eq([@merchant_1, @merchant_2, @merchant_4])      
    end

    it "#inactive" do
      expect(Merchant.inactive).to eq([@merchant_3, @merchant_5, @merchant_6])      
    end
  end

  describe 'Instance Methods' do 
    before :each do
      @merchant1 = create(:merchant)

      @item_1 = create(:item, merchant: @merchant1)
      @item_2 = create(:item, merchant: @merchant1)

      @invoice_1 = create(:invoice, created_at: "10-10-1999")
      @invoice_2 = create(:invoice, created_at: "10-10-1975")
      @invoice_3 = create(:invoice, created_at: "10-10-1934")
      @invoice_4 = create(:invoice, created_at: "10-10-2021")
      @invoice_5 = create(:invoice, created_at: "10-10-1955")
      @invoice_6 = create(:invoice, created_at: "10-10-1992")

      create(:invoice_items, invoice: @invoice_1, item: @item_1, status: :shipped)
      create(:invoice_items, invoice: @invoice_2, item: @item_1, status: :shipped)
      create(:invoice_items, invoice: @invoice_3, item: @item_1, status: :shipped)
      create(:invoice_items, invoice: @invoice_4, item: @item_1, status: :pending)
      create(:invoice_items, invoice: @invoice_5, item: @item_1, status: :pending)
      create(:invoice_items, invoice: @invoice_6, item: @item_1, status: :pending)

      create(:invoice_items, invoice: @invoice_1, item: @item_2, status: :shipped)
      create(:invoice_items, invoice: @invoice_2, item: @item_2, status: :shipped)
      create(:invoice_items, invoice: @invoice_3, item: @item_2, status: :shipped)
      create(:invoice_items, invoice: @invoice_4, item: @item_2, status: :shipped)
      create(:invoice_items, invoice: @invoice_5, item: @item_2, status: :shipped)
      create(:invoice_items, invoice: @invoice_6, item: @item_2, status: :shipped)
    end

    it 'has items_not_shipped method' do
      expect(@merchant1.items_not_shipped_sorted_by_date).to eq([@invoice_5, @invoice_6, @invoice_4])
      expect(@merchant2.items_not_shipped_sorted_by_date).to eq([@invoice_3, @invoice_2, @invoice_1])
    end

    it '#invoices_distinct_by_merchant' do
      expect(@merchant1.invoices_distinct_by_merchant).to eq([@invoice_1, @invoice_2, @invoice_3,@invoice_4, @invoice_5, @invoice_6])
    end
  end
end