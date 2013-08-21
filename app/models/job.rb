class Job < ActiveRecord::Base  

  belongs_to :invoice
  before_save :calculate_amount
  before_validation :add_end_date

  validates_presence_of :invoice_id, :description, :rate, :hours

  def calculate_amount
    self.amount = rate * hours
  end

  def add_end_date
    if start_date.present? && end_date.blank?
      self.end_date = start_date
    end
  end

  def full_description
    if start_date.present? && end_date.present? && start_date != end_date
      "#{start_date.strftime("%-m/%-d/%y")} &ndash; #{end_date.strftime("%-m/%-d/%y")}: #{description}".html_safe
    elsif start_date.present?
      "#{start_date.strftime("%-m/%-d/%y")}: #{description}"
    else
      description
    end
  end

end
