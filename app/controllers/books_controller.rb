class BooksController < ApplicationController
  skip_before_action :authenticate_request, only: [:index]

  def index
    render json: BookService.new.find_all_books, status: :ok
  end

  def show
    book = BookService.new.find_book_by_id(params[:id])
    return render_not_found unless book

    render json: book, status: :ok
  end

  def create
    book = BookService.new.create_book(book_params)

    if book
      render json: book, status: :created
    else
      render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    book = BookService.new.update_book(params[:id], book_params)
    return render_not_found unless book

    render json: book, status: :ok
    else
      render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    book = BookService.new.find_book_by_id(params[:id])
    return render_not_found unless book

    BookService.new.delete_book(params[:id])
    head :no_content
  end

  private

  def book_params
    params.require(:book).permit(
      :title,
      :price, 
      :stock, 
      :author_id, 
      :available
    )
  end

  def render_not_found
    render json: { error: 'Registro não encontrado' }, status: :not_found
  end
end
