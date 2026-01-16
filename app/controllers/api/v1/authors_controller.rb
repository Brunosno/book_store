module Api
  module V1
    class AuthorsController < ApiController
      skip_before_action :authenticate_request, only: [:index, :create]

      def index
        authors = Author.all.map { |author| convert_to_dto(author) }

        render json: authors, status: :ok
      end

      def show
        author = AuthorService::Show.call(params[:id])
        if author
          render json: author, status: :ok
        else
          render json: { error: 'Registro não encontrado' }, status: :not_found
        end
      end

      def create
        author = AuthorService::Create.call(author_params)
        if author
          render json: author, status: :created
        else
          render json: author.errors, status: :unprocessable_entity
        end
      end

      def update
        author = AuthorService::Update.call(params[:id], author_params)
        if author
          render json: author, status: :ok
        else
          render json: author.errors, status: :unprocessable_entity
        end
      end

      def destroy
        author = AuthorService::Show.call(params[:id])
        author.destroy!
        head :no_content
      end

      private

      def author_params
        params.require(:author).permit(:name, :biography, :email)
      end

      def convert_to_dto(author)
        {
          id: author.id,
          name: author.name,
          email: author.email,
          biography: author.biography
        }
    end
  end
end