class BooksController < ApplicationController
  skip_before_action :authenticate_request, only: [:index]

  def index
    render json: Book.all, status: :ok
  end

  def show
    book = Book.find_by(id: params[:id])
    return render_not_found unless book

    render json: book, status: :ok
  end

  def create
    book = Book.new(book_params)

    if book.save
      render json: book, status: :created
    else
      render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    book = Book.find_by(id: params[:id])
    return render_not_found unless book

    if book.update(book_params)
      render json: book, status: :ok
    else
      render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    book = Book.find_by(id: params[:id])
    return render_not_found unless book

    book.destroy
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
