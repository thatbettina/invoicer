class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer  :invoice_id
      t.string   :description
      t.float    :rate
      t.float    :hours
      t.float    :amount
      t.date     :start_date
      t.date     :end_date
      t.timestamps
    end
  end
end
