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
    @customer_1 = create(:customer)
    @invoice_1 = create(:invoice, status: :completed, created_at: "08-10-2022", customer: @customer_1)

    @item_1 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, name: "item_3", merchant: @merchant_1)
    @item_5 = create(:item, name: "item_5", merchant: @merchant_1, active_status: :enabled)
    @item_10 = create(:item, name: "item_10", merchant: @merchant_1)
    # @transactions_1 = create_list(:transaction, 3, result: :failed, invoice: @invoice_1)
    # @transactions_2 = create_list(:transaction, 5, result: :success, invoice: @invoice_1)
    
    @discount_1 = @merchant_1.discounts.create!(discount_amount: 0.2, threshold: 10)
    
    @invoice_item1 = create(:invoice_items, item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 2000, status: :packaged)
    @invoice_item2 = create(:invoice_items, invoice: @invoice_1, item: @item_10, unit_price: 1000, quantity: 10)
    @invoice_item3 = create(:invoice_items, invoice: @invoice_1, item: @item_5, unit_price: 900, quantity: 9)
    @invoice_item4 = create(:invoice_items, invoice: @invoice_1, item: @item_3, unit_price: 800, quantity: 8)
  end

  it '#total_discounted_revenue (US#6)' do
    expect(@invoice_1.items.total_revenue_of_all_items).to eq(24500)
    expect(@invoice_1.total_discounted_revenue).to eq(22500)
  end

  
end