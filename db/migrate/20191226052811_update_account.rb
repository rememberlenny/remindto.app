class UpdateAccount < ActiveRecord::Migration[6.0]
  def change
    remove_column(:accounts, :remove_branding_flag)
    remove_column(:accounts, :cta)
    remove_column(:accounts, :description)
    remove_column(:accounts, :color)
    remove_column(:accounts, :logo_url)
    add_column(:accounts, :publication_size, :string)
  end
end


# t.string "domain"
# t.string "logo_url"
# t.integer "owner_id"
# t.integer "webhook_id"
# t.datetime "created_at", precision: 6, null: false
# t.datetime "updated_at", precision: 6, null: false
# t.string "company_name"
# t.string "uid"
# t.boolean "has_script_setup"
# t.boolean "remove_branding_flag", default: false
# t.string "cta", default: ""
# t.string "description", default: ""
# t.string "color", default: ""