class Api::BasketsController < ActionController::API
  def create
    render json: serialized_basket
  end

  private

  def serialized_basket
    BasketSerializer.new(items: items, price: calculated_price).as_json    
  end

  def items
    params.require(:items).map do |item|
      item.permit(:code, :quantity)
    end
  end

  def calculated_price
    PriceCalculatorService.calculate(items)
  end
end