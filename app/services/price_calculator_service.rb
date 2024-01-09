class PriceCalculatorService
  attr_reader :items

  def initialize(items:)
    @items = items
  end

  def self.calculate(items)
    new(items: items).calculate
  end

  def calculate
    total_price = 0

    items.each do |item|
      total_price += calculate_items_price(item)
    end
  
    total_price
  end

  private

  def calculate_items_price(item)

    price = product_price(item) * item[:quantity]

    if apply_mug_discount?(item)
      price -= (price * discount_percentage(item))
    elsif apply_tshirt_discount?(item)
      price -= (price * 0.3)
    end

    price
  end

  def discount_percentage(item)
    if item[:quantity] >= 150
      0.3
    else
      calculate_percentage(item[:quantity])
    end
  end

  def calculate_percentage(item_quantity)
    (item_quantity / 10) * 0.02
  end

  def apply_mug_discount?(item)
    item[:code] == 'MUG' && item[:quantity] >= 10
  end

  def apply_tshirt_discount?(item)
    item[:code] == 'TSHIRT' && item[:quantity] >= 3
  end

  def product_price(item)
    Product.find_by(code: item[:code]).price
  end
end