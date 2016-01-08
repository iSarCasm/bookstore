class CartItem
  attr_reader :id, :quantity

  def initialize(item_id, quantity = 1)
    @id = item_id
    @quantity = quantity
  end

  # Restoring from Cookies
  def self.restore(hash)
    CartItem.new(hash["id"], hash["quantity"])
  end

  def increase
    @quantity += 1
  end
end
