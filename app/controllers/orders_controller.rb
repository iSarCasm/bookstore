class OrdersController < ApplicationController
  load_and_authorize_resource

  def index
    @orders = current_user.orders
    @in_progress  = @orders.select{ |x| x.in_progress? }
    @in_queue     = @orders.select{ |x| x.in_queue? }
    @in_delivery  = @orders.select{ |x| x.in_delivery? }
    @delivered    = @orders.select{ |x| x.delivered? }
  end

  def show
  end

  private

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
