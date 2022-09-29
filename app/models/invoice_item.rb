class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity, :unit_price
  validates :quantity, numericality: true
  validates :unit_price, numericality: true

  belongs_to :item
  belongs_to :invoice

  has_many :merchants, through: :item
  has_many :discounts, through: :item

  enum status: { pending: 0, packaged: 1, shipped: 2}


end
