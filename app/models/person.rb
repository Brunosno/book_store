class Person < ApplicationRecord
    self.table_name = "persons"
    
    has_many :addresses, dependent: :destroy
    has_one :phone, dependent: :destroy

    validates :name, presence: true, format: {
        with: /\A[a-zA-ZÀ-ÿ\s]+\z/,
        message: "deve conter apenas letras"
        }

    validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end