class Shipment < ApplicationRecord
  belongs_to :user
  belongs_to :delivery_partner, class_name: 'User', foreign_key: 'delivery_partner_id', optional: true

  enum status: { not_started: 'not_started', in_progress: 'in_progress', delivered: 'delivered' }
end
