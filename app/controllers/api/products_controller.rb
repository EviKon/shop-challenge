class Api::ProductsController < ActionController::API
  def index
    render json: serialized_products
  end

  def update
    if product && product.update(price: product_price)
      render json: success_message, status: :ok
    else
      render json: not_found_message, status: :unprocessable_entity
    end
  end

  private

  def product
    Product.find_by(code: product_code)
  end

  def product_code
    params[:code]
  end

  def product_price
    params.require(:price)
  end

  def products
    Product.all
  end

  def serialized_products
    products.map { |product| ProductSerializer.new(product: product) }
  end

  def serialized_product
    ProductSerializer.new(product: product).as_json
  end

  def success_message
    {
      message: 'Product updated successfully', 
      data: serialized_product
    }
  end

  def not_found_message
    {
      message: 'We occured a problem while processing your request.',
      data: {}
    }
  end
end
