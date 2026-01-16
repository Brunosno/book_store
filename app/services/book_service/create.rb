module BookService
  class Create < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      create_book(@params)
    end

    private

    def create_book(params)
        book = @book_model.new(params)

        if book.save
            convert_to_dto(book)
        else
            raise ActiveRecord::RecordInvalid.new(book)
        end
    end

    def convert_to_dto(book)
        {
            id: book.id,
            title: book.title,
            description: book.description,
            price: book.price,
            author: AuthorService::Show.call(book.author_id)[:name],
            stock: book.stock,
            available: book.available,
        }
    end
  end
end