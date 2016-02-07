class OrdersController < ApplicationController

  def edit_address
    @order = Order.find(params[:id])
    check_user_for!(@order)
  end

  def edit_delivery
    @order = Order.find(params[:id])
    check_user_for!(@order)
  end

  def edit_payment
    @order = Order.find(params[:id])
    check_user_for!(@order)
  end

  def confirm
    @order = Order.find(params[:id])
    check_user_for!(@order)
  end

  def complete
    @order = Order.find(params[:id])
    check_user_for!(@order)
  end

  def update
    order = Order.find(params[:id])
    check_user_for!(order)
    order.update(order_params)
    flash[:errors] = order.errors.messages
    redirect_to :back
  end

  private

    def check_user_for!(order)
      if (current_user != order.user)
        fail "Permission denied."
      end
    end

    def order_params
      params.require(:order).permit(
        billing_address_attributes: [
          :id,
          :first_name,
          :last_name,
          :street_address,
          :city,
          :country,
          :zip,
          :phone
        ],
        shipment_address_attributes: [
          :id,
          :first_name,
          :last_name,
          :street_address,
          :city,
          :country,
          :zip,
          :phone
        ],
        shipment: [
          :id
        ],
        payment: [
          :card,
          :expiration_year,
          :expiration_month,
          :cvv
        ]
      )
    end
end
