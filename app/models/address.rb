class Address < ApplicationRecord
    belongs_to :person

    validates :street, :city, :state, :zip_code, presence: true
end