class Public::CartItemsController < ApplicationController

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart = @cart_item.cart
    if @cart_item.destroy
      if @cart.cart_items.count == 0
        @cart.destroy
        redirect_to carts_path
      else
        redirect_to carts_path
      end
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :cart_id)
  end
  
end
