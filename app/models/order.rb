class Order < ApplicationRecord
    belongs_to :user, foreign_key: :user_id, optional: false
    has_many :order_items, dependent: :destroy
    has_many :books, through: :order_items

    enum :status, {
        pending: 0,
        paid: 1,
        shipped: 2,
        delivered: 3,
        canceled: 4
    }

    validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
end