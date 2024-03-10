class CreateShipments < ActiveRecord::Migration[6.0]
  def change
    create_table :shipments do |t|
      t.string :source
      t.string :target
      t.string :item
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.integer :delivery_partner_id

      t.timestamps
    end
    add_foreign_key :shipments, :users, column: :delivery_partner_id
  end
end
