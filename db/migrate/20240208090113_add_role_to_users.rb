class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    def change
      add_column :users, :role, :string, default: 'user'
    end
  end
end
