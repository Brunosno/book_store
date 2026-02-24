module Api
  module V1
    class BooksController < ApiController
      skip_before_action :authenticate_request, only: [:index, :create, :update]

      def index
        books = Book.all.map { | book | convert_to_dto(book) }

        render json: books, status: :ok
      end

      def show
        book = BookService::Show.call(params[:id])

        return render_not_found unless book

        render json: book, status: :ok
      end

      def create
        book = BookService::Create.call(book_params)

        if book
          render json: book, status: :created
        else
          render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        book = BookService::Update.call(params[:id], book_params)
        return render_not_found unless book

        render json: book, status: :ok
      end

      def destroy
        book = BookService::Show.call(params[:id])
        return render_not_found unless book

        book.destroy(params[:id])
        head :no_content
      end

      private

      def book_params
        params.require(:book).permit(
          :title,
          :description,
          :price,
          :stock,
          :author_id,
          :available
        )
      end

      def render_not_found
        render json: { error: 'Registro não encontrado' }, status: :not_found
      end

      def convert_to_dto(book)
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
end
