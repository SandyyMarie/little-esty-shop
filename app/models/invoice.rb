class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  has_many :merchants, through: :items
  has_many :discounts, through: :merchants

  enum status: { "in progress": 0, completed: 1, cancelled: 2 }

  def self.unshipped_invoices
    joins(:invoice_items)
    .where.not(invoice_items: {status: 2})
    .distinct
  end

  def self.successful_transactions_count
    sum do |invoice|
      invoice.transactions.where(result: 0).count
    end
  end

  def self.sort_by_date
    order(:created_at)
  end

  def self.best_day
    where(invoices: {status: :completed})
    .group(:id)
    .select('invoices.created_at, invoices.id, count(invoices.id) as sales')
    .order('sales desc, created_at')
    .first
  end

  def total_revenue_of_invoice
    items.total_revenue_of_all_items
    # invoice_items.sum("quantity * unit_price")
  end

  def total_discounted_revenue

    Invoice.from(invoice_items.joins(item:[merchant: :discounts]).where("invoice_items.quantity >= discounts.threshold").select('invoice_items.id, max(invoice_items.quantity * invoice_items.unit_price * discounts.discount_amount) as discounted_total').group("invoice_items.id")).sum('discounted_total')
  end

  def total_rev_with_discount
    total_revenue_of_invoice - total_discounted_revenue
  end
end
