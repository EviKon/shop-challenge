class Product < ApplicationRecord
  validates :code, presence: true
  validates :price, numericality: { greater_than: 0 }, presence: true
  validates :name, presence: true
end
