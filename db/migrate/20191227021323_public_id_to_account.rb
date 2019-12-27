class PublicIdToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :public_uid, :string
    add_index  :accounts, :public_uid
  end
end
