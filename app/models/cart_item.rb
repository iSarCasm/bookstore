class CartItem
  attr_reader :id, :quantity

  def initialize(item_id)
    @id = item_id
    @quantity = 1
  end

  def increase
    @quantity += 1
  end
end
