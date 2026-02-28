module Api
  module V1
    class BooksController < ApiController
      skip_before_action :authenticate_request, only: [:index, :show]
      before_action :authorize_admin!, only: [:create, :update, :destroy]

      def index
        per_page = [params[:per_page].to_i, 50].min
        per_page = 10 if per_page <= 0

        books = Book.includes(:author)
                    .page(params[:page])
                    .per(per_page)

        render_success(
          data: books.map { |book| convert_to_dto(book) },
          message: "Books retrieved successfully",
          meta: pagination_meta(books)
        )
      end

      def show
        book = Book.includes(:author).find(params[:id])

        render_success(
          data: convert_to_dto(book),
          message: "Book retrieved successfully"
        )
      end

      def create
        book = BookService::Create.call(book_params)

        render_success(
          data: book,
          message: "Book created successfully",
          status: :created
        )
      end

      def update
        book = BookService::Update.call(params[:id], book_params)

        render_success(
          data: book,
          message: "Book updated successfully"
        )
      end

      def destroy
        Book.find(params[:id]).destroy!

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

      def convert_to_dto(book)
        {
          id: book.id,
          title: book.title,
          description: book.description,
          price: book.price,
          stock: book.stock,
          available: book.available,
          author: {
            id: book.author&.id,
            name: book.author&.name
          }
        }
      end

      def pagination_meta(collection)
        {
          current_page: collection.current_page,
          next_page: collection.next_page,
          prev_page: collection.prev_page,
          total_pages: collection.total_pages,
          total_count: collection.total_count
        }
      end
    end
  end
end