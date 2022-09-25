class DiscountsController < ApplicationController

  def index
    @discounts = Discount.all #.find(params[:merchant_id])
    @merchant = Merchant.find(params[:merchant_id])

  end

  def show
    @discount = Discount.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end
end