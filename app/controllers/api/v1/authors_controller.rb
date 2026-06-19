module Api
  module V1
    class AuthorsController < ApiController
      skip_before_action :authenticate_request, only: [:index]
      before_action :authorize_admin!, only: [:show, :update, :destroy]

      def index
        per_page = [params[:per_page].to_i, 50].min
        per_page = 10 if per_page <= 0

        authors = Author.page(params[:page]).per(per_page)

        render_success(
          data: authors.map { |author| convert_to_dto(author) },
          message: "Authors retrieved successfully",
          meta: pagination_meta(authors)
        )
      end

      def show
        author = Author.find(params[:id])

        render_success(
          data: convert_to_dto(author),
          message: "Author retrieved successfully"
        )
      end

      def create
        author = AuthorService::Create.call(author_params)

        render_success(
          data: author,
          message: "Author created successfully",
          status: :created
        )
      end

      def update
        author = AuthorService::Update.call(params[:id], author_params)

        render_success(
          data: author,
          message: "Author updated successfully"
        )
      end

      def destroy
        Author.find(params[:id]).destroy!

        head :no_content
      end

      private

      def author_params
        params.require(:author)
              .permit(:name, :biography, :email)
      end

      def convert_to_dto(author)
        {
          id: author.id,
          name: author.name,
          email: author.email,
          biography: author.biography
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