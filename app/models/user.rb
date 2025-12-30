class User < Person
    has_secure_password
    validates :username, presence: true, uniqueness: true, length: { minimum: 3 }
    validates :is_admin, inclusion: { in: [true, false] }

    has_many :orders, foreign_key: :user_id
end