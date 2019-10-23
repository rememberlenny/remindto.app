class CreateWebhookActions < ActiveRecord::Migration[6.0]
  def change
    create_table :webhook_actions do |t|
      t.integer :webhook_id
      t.string :result

      t.timestamps
    end
  end
end
