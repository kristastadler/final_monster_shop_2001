class Merchant::DiscountsController < Merchant::BaseController

  def index
    @merchant = Merchant.find(current_user.merchant_id)
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def new
    item = Item.find(params[:item_id])
    @discount = item.discounts.new
  end

  def create
    item = Item.find(params[:item_id])
    discount = item.discounts.new(discount_params)
    if discount.save
      flash[:success] = "New discount added successfully"
      redirect_to "/merchant/discounts/#{discount.id}"
    else
      flash[:error] = discount.errors.full_messages.to_sentence
      redirect_back(fallback_location: "/")
    end
  end

  def edit
    @discount = Discount.find(params[:id])
  end

  def update
    discount = Discount.find(params[:id])
  if discount.update(discount_params)
    flash[:success] = "Discount has been updated!"
    redirect_to "/merchant/discounts/#{discount.id}"
  else
    flash[:error] = discount.errors.full_messages.to_sentence
    redirect_back(fallback_location: "/")
  end
  end

  def destroy
    discount = Discount.find(params[:id])
    discount.destroy
    flash[:success] = "Discount successfully deleted"

    redirect_to "/merchant/discounts"
  end

private

  def discount_params
    params[:discount].permit(:description, :discount_amount, :minimum_quantity)
  end

end
