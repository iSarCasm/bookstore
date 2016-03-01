class ShoppingCart
  attr_reader :items
  SESSION_KEY = :cart

  def initialize(session = {})
    @@session = session
    @items = []
    restore(session[SESSION_KEY])
  end

  def add(book, count = 1)
    book = accept_book_model(book)
    count.times do
      if present?(book)
        find(book).increase
      else
        @items << CartItem.new(book)
      end
    end
  end

  def clear
    @items = []
    @coupon = nil
  end

  def apply_coupon(coupon)
    @coupon = accept_coupon_model(coupon)
  end

  def sum_without_discount
    @items.inject(0) { |sum, item| sum + item.sum }
  end

  def sum
    sum_without_discount * (1 - discount)
  end

  def coupon
    Coupon.find_by(name: @coupon)
  end

  def size
    @items.inject(0) { |size, item| size + item.quantity }
  end

  def discount_string
    "-#{(coupon.discount*100).to_i}%" if coupon
  end

  def discount
    coupon ? coupon.discount : 0
  end

  def empty?
    size == 0
  end

  def update(id, quantity)
    find(id).quantity = quantity.to_i
  end

  def save
    @@session[SESSION_KEY] = self
  end

  private

  def accept_book_model(model)
    model.is_a?(Book) ? model.id : model
  end

  def accept_coupon_model(model)
    model.is_a?(Coupon) ? model.name : model
  end

  def restore(hash)
    return unless @@session[SESSION_KEY]
    hash["items"].each do |item|
      @items << CartItem.restore(item)
    end
    @coupon = hash["coupon"]
  end

  def present?(book_id)
    @items.any? { |item| item.id == book_id }
  end

  def find(book_id)
    @items.find { |item| item.id == book_id }
  end
end
