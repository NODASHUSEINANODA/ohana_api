class AddColumnCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :password, :string, after: :email, null: false
  end
end
