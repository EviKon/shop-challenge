require 'rails_helper'

RSpec.describe Api::ProductsController, type: :request do
  describe 'GET /api/products' do
    let(:products) do
      [FactoryBot.create(:product)]
    end

    let(:expected_products) do
      [
        {
          'code' => 'MUG',
          'name' => 'Mug',
          'price' => '6.0'
        }
      ]
    end

    before do
      allow(Product).to receive(:all).and_return(products)
    end

    it 'responds with ok status' do
      get api_products_path
  
      expect(response).to have_http_status :ok
    end

    it 'responds with the products' do
      get api_products_path
      
      expect(JSON.parse(response.body)).to eql(expected_products)
    end
  end

  describe 'PUT /api/products/:code' do
    let(:product) { FactoryBot.create(:product) }

    let(:params) do
      {
        "price": "10.0"
      }
    end

    let(:expected_response) do
      {
        'data' => {
          'code' => product.code,
          'name' => product.name,
          'price' => '10.0'
        },
        'message' => 'Product updated successfully'
      }
    end

    it 'responds with the products' do
      put api_product_path(product.code), params: params
      
      expect(response).to have_http_status :ok
      expect(JSON.parse(response.body)).to eql(expected_response)
    end

    context 'when the product does not exist' do
      let(:non_existent_product_code) { 'non-existent-code' }
      let(:expected_response) do
        {
          'data' => {},
          'message' => 'We occured a problem while processing your request.'
        }
      end

      it 'responds with a unprocessable entity status and a message' do
        put api_product_path(non_existent_product_code), params: params

        expect(response).to have_http_status :unprocessable_entity
        expect(JSON.parse(response.body)).to eql(expected_response)
      end
    end

    context 'when the price is not passed correctly' do
      let(:params) {{}}

      it 'responds with a bad request response' do
        put api_product_path(product.code), params: params

        expect(response).to have_http_status :bad_request
      end
    end

    context 'when the price did not save' do
      let(:params) do
        {
          "price": "10.0"
        }
      end

      before do
        allow(Product).to receive(:find_by).with(code: product.code).and_return(product)
        allow(product).to receive(:update).with(price: "10.0").and_return(false)
      end

      it 'responds with unprocessable entity status and a message' do
        put api_product_path(product.code), params: params

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end
end