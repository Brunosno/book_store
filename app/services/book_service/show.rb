module BookService
  class Show < ApplicationService
    def initialize(book_id)
      @book_id = book_id
    end

    def call
      find_book_by_id(@book_id)
    end

    private

    def find_book_by_id(book_id)
      book = Book.find_by(id: book_id)
      if book
        convert_to_dto_response(book)
      else
        raise ActiveRecord::RecordNotFound, "Book with id #{book_id} not found"
      end
    end

    def convert_to_dto_response(book)
      {
        id: book.id,
        title: book.title,
        description: book.description,
        price: book.price,
        author: AuthorService::Show.call(book.author_id)[:name],
        stock: book.stock,
        available: book.available
      }
    end
  end
end