class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.date     :date
      t.string   :po, default: "", null: false
      t.string   :number
      t.string   :memo, default: "", null: false
      t.integer  :company_id
      t.float    :total
      t.float    :discount
      t.float    :billed
      t.float    :paid
      t.date     :payday
      t.timestamps
    end
  end
end
