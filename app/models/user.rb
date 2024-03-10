class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  enum role: [:admin, :customer, :delivery_partner]
  has_many :shipments, dependent: :nullify, foreign_key: 'user_id' 
  has_many :assigned_shipments, class_name: 'Shipment', foreign_key: 'delivery_partner_id', dependent: :nullify 

  # validates :full_name, presence: true, length: { maximum: 50 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable         
end
