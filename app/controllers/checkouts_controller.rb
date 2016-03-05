class CheckoutsController < ApplicationController
  load_and_authorize_resource :order, class: Order, parent: false

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
    if @order.address_invalid?
      redirect_to action: :edit_address
    elsif @order.delivery_invalid?
      redirect_to action: :edit_delivery
    elsif @order.payment_invalid?
      redirect_to action: :edit_payment
    else
      @order.enqueue
      @order.save
      redirect_to @order
    end
  end

  private

  def go_to_next_step
    puts 'next step'
    case params[:order][:step]
    when 'address'
      redirect_to edit_delivery_checkout_path(@order)
    when 'shipment'
      redirect_to edit_payment_checkout_path(@order)
    when 'payment'
      redirect_to confirm_checkout_path(@order)
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
        :id,
        :card,
        :expiration_year,
        :expiration_month,
        :cvv
      ]
    )
  end
end
