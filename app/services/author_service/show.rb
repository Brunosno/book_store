module AuthorService
  class Show < ApplicationService
    def initialize(author_id)
      @author_id = author_id
    end

    def call
      find_author_by_id(@author_id)
    end

    private

    def find_author_by_id(author_id)
      author = Author.find_by(id: author_id)
      if author
        convert_to_dto_response(author)
      else
        raise ActiveRecord::RecordNotFound, "Author with id #{author_id} not found"
      end
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