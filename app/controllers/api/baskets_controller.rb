class Api::BasketsController < ActionController::API
  def create
    if quantity_params_negative?
      render_bad_request
    else
      render json: serialized_basket
    end
  end

  private

  def quantity_params_negative?
    quantities.any?(&:negative?)
  end

  def quantities
    items.map { |item| item[:quantity].to_i }
  end

  def render_bad_request
    render json: { error: error_message }, status: :bad_request
  end

  def serialized_basket
    BasketSerializer.new(items: items, price: calculated_price).as_json
  end

  def error_message
    'Parameters not valid, quantity needs to be a natural number'
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