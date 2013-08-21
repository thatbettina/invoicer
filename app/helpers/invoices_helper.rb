module InvoicesHelper

  # Currency
  def currency(num)
    num && !num.nan? && !num.infinite? ? "#{number_to_currency(num)}" : ""
  end

  def negative_currency(num)
    "-#{currency(num)}"
  end

  def decimals(num)
    num && !num.nan? ? "#{number_with_precision(num, precision: 2)}" : ""
  end

  # Date
  def slash_date(date)
    h date.strftime("%-m/%-d/%y")
  end

end
