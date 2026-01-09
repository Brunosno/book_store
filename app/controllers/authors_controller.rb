class AuthorsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index]

  def index
    authors = AuthorService.new.find_all_authors

    render json: authors, status: :ok
  end

  def show
    author = AuthorService.new.find_author_by_id(params[:id])
    if author
      render json: author, status: :ok
    else
      render json: { error: 'Registro não encontrado' }, status: :not_found
    end
  end

  def create
    author = AuthorService.new.create_author(author_params)
    if author
      render json: author, status: :created
    else
      render json: author.errors, status: :unprocessable_entity
    end
  end

  def update
    author = AuthorService.new.update_author(params[:id], author_params)
    if author
      render json: author, status: :ok
    else
      render json: author.errors, status: :unprocessable_entity
    end
  end

  def destroy
    AuthorService.new.delete_author(params[:id])
    head :no_content
  end

  private
  def author_params
    params.require(:author).permit(:name, :biography, :email)
  end
end
