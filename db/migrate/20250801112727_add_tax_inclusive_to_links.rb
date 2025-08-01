class AddTaxInclusiveToLinks < ActiveRecord::Migration[7.1]
  def change
    add_column :links, :tax_inclusive, :boolean, null: false, default: false
  end
end
