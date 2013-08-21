class Company < ActiveRecord::Base

  has_many :invoices, -> { order(date: :asc) }

  validates_presence_of :name
  validates_uniqueness_of :name

  def invoices_paid
    Invoice.where("company_id = ?", id).sum(:paid)
  end

  def invoices_total
    Invoice.where("company_id = ?", id).sum(:billed)
  end

  def invoice_days
    invoices = Invoice.where("company_id = ?", id).order("date ASC")
    invoice_first = invoices.first
    invoice_last = invoices.last
    invoice_days = (Date.parse("#{invoice_last.date}") - Date.parse("#{invoice_first.date}")).to_i + 1 if invoice_first.present? && invoice_last.present?
  end

  def invoice_years
    invoice_years = sprintf('%.2f', invoice_days / 365) if invoice_days.present?
  end

end
