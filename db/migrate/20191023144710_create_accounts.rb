class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :domain
      t.string :logo_url
      t.integer :owner_id
      t.integer :webhook_id
      t.timestamps
      t.string :company_name
      t.string :uid
      t.boolean :has_script_setup
      t.boolean :remove_branding_flag, default: false
      t.string :cta, default: ""
      t.string :description, default: ""
      t.string :color, default: ""
    end
  end
end
