class Author < Person
    has_many :books, foreign_key: :author_id, dependent: :destroy

    validates :biography, presence: true, length: { maximum: 1000 }
end