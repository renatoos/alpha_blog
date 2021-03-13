class AddUserPassword < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :password, :string
    add_column :users, :email, :string
    remove_column :users, :created_at
    remove_column :users, :updated_at
  end
end
