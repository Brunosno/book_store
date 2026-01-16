module AuthorService
  class Create < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      create_author(@params)
    end

    private

    def create_author(params)
      author = Author.new(convert_to_dto(params))

      if author.save
        convert_to_dto_response(author)
      else
        raise ActiveRecord::RecordInvalid.new(author)
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