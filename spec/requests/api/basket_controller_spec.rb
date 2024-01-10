require 'rails_helper'

RSpec.describe Api::BasketsController, type: :request do
  describe 'POST create' do
    context 'when items is not empty' do
      let(:params) do
        {  
          items: [
            {
              'code': 'MUG',
              'quantity': 1
            },
            {
              'code': 'TSHIRT',
              'quantity': 1
            },
            {
              'code': 'HOODIE',
              'quantity': 1
            }
          ]
        }
      end

      let(:expected_result) do
        {
          Items: '1 MUG, 1 TSHIRT, 1 HOODIE',
          Total: 41.0
        }
      end

      before do
        allow(PriceCalculatorService).to receive(:calculate).and_return(41.0)
      end

      it 'renders serialized_basket as json' do
        post '/api/baskets', params: params
        
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq(expected_result.to_json)
      end
    end

    context 'when param items are not passed' do
      it 'renders json with error message and status: bad_request' do
        
        post '/api/baskets', params: {}
        
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when quantity is passed as a negative price' do
      it 'renders json with error message and status: bad_request' do
        
        post '/api/baskets', params: {}
        
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end