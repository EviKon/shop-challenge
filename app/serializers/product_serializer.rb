class ProductSerializer
  attr_reader :product

  def initialize(product:)
    @product = product
  end

  def as_json
    {
      code: product.code,
      name: product.name,
      price: product.price
    }
  end
end