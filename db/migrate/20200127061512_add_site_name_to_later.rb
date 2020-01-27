class AddSiteNameToLater < ActiveRecord::Migration[6.0]
  def change
    add_column :laters, :site_name, :string
  end
end
