class Invoice < ActiveRecord::Base

  belongs_to :company
  has_many :jobs, -> { order(start_date: :asc) }
  before_save :add_total

  validates_presence_of :date, :number, :company_id

  def due_date
    date + 30.days
  end

  def add_total
    sum = Job.where("invoice_id = ?", id).sum(:amount)
    if sum && sum > 0
      self.total = sum
    end
    if discount && discount > 0
      self.billed = total - discount
    else
      self.billed = total
    end
  end

end
