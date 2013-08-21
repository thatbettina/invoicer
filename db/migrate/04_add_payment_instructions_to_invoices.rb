class AddPaymentInstructionsToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :payment_instructions, :string, :after => :payday
  end
end
