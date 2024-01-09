require 'rails_helper'

RSpec.describe BasketSerializer do
  subject { described_class.new(items: items, price: price) }
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

  let(:price) { 41.0 }

  let(:expected_result) do
    {
      Items: '1 MUG, 1 TSHIRT, 1 HOODIE',
      Total: 41.0
    }
  end

  describe '#as_json' do
    it 'returns the correct JSON response' do
      expect(subject.as_json).to eq(expected_result)
    end
  end
end