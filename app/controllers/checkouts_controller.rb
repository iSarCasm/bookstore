class CheckoutsController < ApplicationController
  # load_and_authorize_resource class: 'Order'
  before_filter :get_order_for_edit

  def edit_address
    @current_step = :address
  end

  def edit_delivery
    @current_step = :shipment
    @available_shipments = Shipment.all.to_a
  end

  def edit_payment
    @current_step = :payment
  end

  def confirm
    @current_step = :confirm
  end

  def update
    @order.update(order_params)
    flash[:errors] = @order.errors.messages
    if @order.errors.empty?
      go_to_next_step
    else
      redirect_to :back
    end
  end

  def place
    if address_invalid?
      redirect_to action: :edit_address
    elsif delivery_invalid?
      redirect_to action: :edit_delivery
    elsif payment_invalid?
      redirect_to action: :edit_payment
    else
      @order.enqueue
      @order.save
      redirect_to @order
    end
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

  def address_invalid?
    !(@order.billing_address && @order.billing_address.valid?) ||
    !(@order.shipment_address && @order.shipment_address.valid?)
  end

  def delivery_invalid?
    !(@order.shipment)
  end

  def payment_invalid?
    !(@order.payment && @order.payment.valid?)
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

  def go_to_next_step
    case params[:order][:step]
    when 'address'
      redirect_to edit_delivery_checkout_path(@order)
    when 'shipment'
      redirect_to edit_payment_checkout_path(@order)
    when 'payment'
      redirect_to confirm_checkout_path(@order)
    end
  end
end
