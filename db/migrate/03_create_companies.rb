class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string   :name
      t.string   :email
      t.string   :address, default: "", null: false
      t.string   :phone, default: "", null: false
      t.timestamps
    end
  end
end
