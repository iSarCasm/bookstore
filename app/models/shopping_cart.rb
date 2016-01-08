class ShoppingCart
  attr_reader :items
  SESSION_KEY = :cart

  def initialize(session)
    @@session = session
    @items = []
    restore(session[SESSION_KEY])
  end

  def add(book_id)
    if present?(book_id)
      find(book_id).increase
    else
      @items << CartItem.new(book_id)
    end
    save
  end

  private

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
