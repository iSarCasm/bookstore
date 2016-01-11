class ShoppingCart
  attr_reader :items
  SESSION_KEY = :cart

  def initialize(session = {})
    @@session = session
    @items = []
    restore(session[SESSION_KEY])
  end

  def add(book)
    book = accept_book_model(book)
    if present?(book)
      find(book).increase
    else
      @items << CartItem.new(book)
    end
    save
  end

  def size
    @items.inject(0) { |size, item| size + item.quantity }
  end

  def sum
    @items.inject(0) { |sum, item| sum + item.sum }
  end

  private

  def accept_book_model(model)
    model.is_a?(Book) ? model.id : model
  end

  def restore(hash)
    return unless @@session[SESSION_KEY]
    hash["items"].each do |item|
      @items << CartItem.restore(item)
    end
  end

  def save
    @@session[SESSION_KEY] = self
  end

  def present?(book_id)
    @items.any? { |item| item.id == book_id }
  end

  def find(book_id)
    @items.find { |item| item.id == book_id }
  end
end
