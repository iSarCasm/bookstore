class OrdersController < ApplicationController
  before_filter :get_order, only: [:show]

  def index
    @orders = current_user.orders
  end

  def show
  end

  private

  def get_order
    @order = Order.find(params[:id])
    check_user_for!(@order)
  end

  def get_order_for_edit
    get_order
    fail 'You cant edit this one' unless @order.in_progress?
  end

  def check_user_for!(order)
    if (current_user != order.user)
      fail "Permission denied."
    end
  end

  def order_params
    params.require(:order).permit(
      :shipment_id,
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
      payment_attributes: [
        :card,
        :expiration_year,
        :expiration_month,
        :cvv
      ]
    )
  end
end
