class OrdersController < ApplicationController
  before_filter :get_order_for_edit, only: [:edit_address, :edit_delivery,
    :edit_payment, :confirm, :update, :place]
  before_filter :get_order, only: [:show]

  def index
    @orders = current_user.orders
  end

  def edit_address
  end

  def edit_delivery
    @available_shipments = Shipment.all.to_a
  end

  def edit_payment
  end

  def confirm
  end

  def show
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
    @order.enqueue
    @order.save
    redirect_to show_path(@order)
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

    def go_to_next_step
      case params[:order][:step]
      when 'address'
        redirect_to edit_delivery_path(@order)
      when 'shipment'
        redirect_to edit_payment_path(@order)
      when 'payment'
        redirect_to confirm_path(@order)
      end
    end
end
