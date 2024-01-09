require 'rails_helper'

RSpec.describe ProductSerializer do
    subject { described_class.new(product: product) }

    let(:product) do
        instance_double(
            Product,
            code: 'code',
            name: 'name',
            price: 1.00
        )
    end

    let(:serialized_product) do
        {
            code: 'code',
            name: 'name',
            price: 1.00
        }
    end

    it 'returns a serialised version of the product' do
        expect(subject.as_json).to eql(serialized_product)
    end
end