class Phone < ApplicationRecord
    belongs_to :person

    validates :ddd, :number, presence: true
end