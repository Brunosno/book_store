module AuthorService
  class Update < ApplicationService
    def initialize(author_id, params)
      @author_id = author_id
      @params = params
    end

    def call
      update_author(@author_id, @params)
    end

    private

    def update_author(author_id, params)
      author = Author.find_by(id: author_id)

      if author
        author.update!(convert_to_dto(params))
        convert_to_dto_response(author)
      else
        raise ActiveRecord::RecordNotFound.new("Author not found")
      end
    end

    def convert_to_dto(author)
      {
        name: author[:name],
        email: author[:email],
        biography: author[:biography]
      }.compact
    end

    def convert_to_dto_response(author)
      {
        id: author.id,
        name: author.name,
        email: author.email,
        biography: author.biography
      }
    end
  end
end