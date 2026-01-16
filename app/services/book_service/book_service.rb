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

    def find_books_by_author_id(author_id)
        books = @book_model.where(author_id: author_id)

        if books.any?
            books.map { |book| convert_to_dto(book) }
        else
            raise ActiveRecord::RecordNotFound, "No books found for author with id #{author_id}"
        end
    end

    def find_books_by_title(title)
        books = @book_model.where("title ILIKE ?", "%#{title}%")

        if books.any?
            books.map { |book| convert_to_dto(book) }
        else
            raise ActiveRecord::RecordNotFound, "No books found with title containing '#{title}'"
        end
    end

    def find_books_with_status_available(available = true)
        books = @book_model.where(available: available)

        if books.any?
            books.map { |book| convert_to_dto(book) }
        else
            raise ActiveRecord::RecordNotFound, "No books found with available status #{available}"
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
            description: book.description,
            price: book.price,
            author: AuthorService.new.find_author_by_id(book.author_id)[:name],
            stock: book.stock,
            available: book.available,
        }
    end
end