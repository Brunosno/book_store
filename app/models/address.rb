class Address < ApplicationRecord
    belongs_to :person

    validates :street, :city, :state, :cep, presence: true
end