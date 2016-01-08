class ShoppingCart
  attr_reader :items

  def initialize
    @items = []
  end

  def add(book_id)
    if present?(book_id)
      find(book_id).increase
    else
      @items << CartItem.new(book_id)
    end
  end

  private

  def present?(book_id)
    @items.any? { |item| item.id == book_id }
  end

  def find(book_id)
    @items.find { |item| item.id == book_id }
  end
end
