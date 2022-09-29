require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should define_enum_for(:status).with_values([:pending, :packaged, :shipped]) }
    it { should validate_numericality_of(:quantity) } 
    it { should validate_numericality_of(:unit_price) } 
  end

  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
  end

    before :each do
      @merchant_1 = create(:merchant)

      @item_3 = create(:item, name: "item_3", merchant: @merchant_1)
      @item_5 = create(:item, name: "item_5", merchant: @merchant_1, active_status: :enabled)
      @item_10 = create(:item, name: "item_10", merchant: @merchant_1)

      @invoice_1 = create(:invoice)

      @discount_1 = @merchant_1.discounts.create!(discount_amount: 0.2, threshold: 10)

      @invoice_item_1 = create(:invoice_items, invoice: @invoice_1, item: @item_10, unit_price: 1000, quantity: 10)
      @invoice_item_1 = create(:invoice_items, invoice: @invoice_1, item: @item_5, unit_price: 900, quantity: 9)
      @invoice_item_1 = create(:invoice_items, invoice: @invoice_1, item: @item_3, unit_price: 800, quantity: 8)
    end

end