class BasketSerializer
  attr_reader :items, :price

  def initialize(items:, price:)
    @items = items
    @price = price
  end

  def as_json
    {
      Items: format_items,
      Total: price
    }
  end

  private

  def format_items
    items.map(&method(:format_item)).join(', ')
  end
 
  def format_item(item)
    "#{item[:quantity]} #{item[:code]}"
  end
end