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
    discount = merchant.discounts.new(discount_params)
    if discount.save
        redirect_to merchant_discounts_path(merchant)
    else
        flash[:alert] = "New discount was NOT saved"
        redirect_to new_merchant_discount_path(merchant)
    end
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    discount = Discount.find(params[:id])

    discount.destroy

    redirect_to merchant_discounts_path(merchant)
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    discount = Discount.find(params[:id])

    discount.update(discount_params)
    redirect_to merchant_discount_path(merchant, discount)
  end
  
  private

  def discount_params
    params.require(:discount).permit(:discount_amount, :threshold)
  end


end