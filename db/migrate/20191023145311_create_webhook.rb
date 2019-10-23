class CreateWebhook < ActiveRecord::Migration[6.0]
  def change
    create_table :webhooks do |t|
      t.string :url
      t.boolean :confirmed
      t.string :type
      t.string :secret
      t.string :trigger
      t.boolean :active

      t.timestamps
    end
  end
end
