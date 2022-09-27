class Discount < ApplicationRecord
  validates_presence_of :discount_amount
  validates_presence_of :threshold

  belongs_to :merchant
end
