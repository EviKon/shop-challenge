require 'rails_helper'

RSpec.describe PriceCalculatorService do
  describe '.calculate' do
    subject { described_class.calculate(items)}

    before do
      FactoryBot.create(:product, code: 'MUG', price: 6)
      FactoryBot.create(:product, code: 'TSHIRT', price: 15.0)
      FactoryBot.create(:product, code: 'HOODIE', price: 20.0)
    end

    context 'when given a basket with 1 mug 1 t-shirt and 1 hoodie' do
      let(:items) do
        [
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
      end

      it 'returns 41.0' do
        expect(subject).to eq(41.0)
      end
    end

    context 'when given a basket with 2 mugs and 1 t-shirt' do
      let(:items) do
        [
          {
            'code': 'MUG',
            'quantity': 2
          },
          {
            'code': 'TSHIRT',
            'quantity': 1
          }
        ]
      end

      it 'returns 27.0' do
        expect(subject).to eq(27.0)
      end
    end

    context 'when given a basket with 3 mugs and 1 t-shirt' do
      let(:items) do
        [
          {
            'code': 'MUG',
            'quantity': 3
          },
          {
            'code': 'TSHIRT',
            'quantity': 1
          }
        ]
      end

      it 'returns 33.0' do
        expect(subject).to eq(33.0)
      end
    end

    context 'when given a basket with 2 mugs 4 t-shirts and 1 hoodie' do
      let(:items) do
        [
          {
            'code': 'MUG',
            'quantity': 2
          },
          {
            'code': 'TSHIRT',
            'quantity': 4
          },
          {
            'code': 'HOODIE',
            'quantity': 1
          }
        ]
      end

      it 'returns 74.0' do
        expect(subject).to eq(74.0)
      end
    end

    context 'when given a basket with 9 mugs and 1 t-shirt' do
      let(:items) do
        [
          {
            'code': 'MUG',
            'quantity': 9
          },
          {
            'code': 'TSHIRT',
            'quantity': 1
          }
        ]
      end

      it 'returns 69.0' do
        expect(subject).to eq(69.0)
      end
    end

    context 'when given a basket with 10 mugs and 1 t-shirt' do
      let(:items) do
        [
          {
            'code': 'MUG',
            'quantity': 10
          },
          {
            'code': 'TSHIRT',
            'quantity': 1
          }
        ]
      end

      it 'returns 73.8' do
        expect(subject).to eq(73.8)
      end
    end

    context 'when given a basket with 45 mugs and 3 t-shirts' do
      let(:items) do
        [
          {
            'code': 'MUG',
            'quantity': 45
          },
          {
            'code': 'TSHIRT',
            'quantity': 3
          }
        ]
      end

      it 'returns 279.90' do
        expect(subject).to eq(279.9)
      end
    end

    context 'when given a basket with 200 mugs 4 t-shirts and 1 hoodie' do
      let(:items) do
        [
          {
            'code': 'MUG',
            'quantity': 200
          },
          {
            'code': 'TSHIRT',
            'quantity': 4
          },
          {
            'code': 'HOODIE',
            'quantity': 1
          }
        ]
      end

      it 'returns 902.0' do
        expect(subject).to eq(902.0)
      end
    end
  end
end