module BookService
  class Update < ApplicationService
    def initialize(book_id, params)
      @book_id = book_id
      @params = params
    end

    def call
      update_book(@book_id, @params)
    end

    private

    def update_book(book_id, params)
      book = Book.find_by(id: book_id)

      if book
        book.update(params)
        convert_to_dto_response(book)
      else
        raise ActiveRecord::RecordNotFound, "Book with #{book_id} not found"
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