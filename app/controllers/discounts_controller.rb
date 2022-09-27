class DiscountsController < ApplicationController

  def index
    @discounts = Discount.all #.find(params[:merchant_id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @discount = Discount.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @discount = Discount.new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    require 'pry'; binding.pry
    discount = merchant.discounts.new(params[:discount])
    if discount.save
        redirect_to merchant_discount_path(merchant)
    else
        flash[:alert] = "New discount was NOT saved"
        redirect_to new_merchant_discount_path(merchant)
    end
  end
end