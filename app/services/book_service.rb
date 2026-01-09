class BookService
    def initialize(book_model = Book)
        @book_model = book_model
    end

    def find_all_books
        @book_model.all.map { |book| convert_to_dto(book) }
    end

    def find_book_by_id(id)
        book = @book_model.find_by(id: id)
        if book
            convert_to_dto(book)
        else
            raise ActiveRecord::RecordNotFound, "Book with id #{id} not found"
        end
    end

    def create_book(params)
        book = @book_model.new(params)

        if book.save
            convert_to_dto(book)
        else
            raise ActiveRecord::RecordInvalid.new(book)
        end
    end

    def update_book(id, params)
        book = @book_model.find_by(id: id)
        if book.update(params)
            convert_to_dto(book)
        else
            raise ActiveRecord::RecordInvalid.new(book)
        end
    end

    def delete_book(id)
        book = @book_model.find_by(id: id)
        book.destroy
    end

    private

    def convert_to_dto(book)
        {
            id: book.id,
            title: book.title,
            price: book.price,
            author: book.author.name,
            stock: book.stock,
            available: book.available,
        }
    end
end