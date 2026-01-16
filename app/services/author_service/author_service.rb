class AuthorService 
    def initialize(author_model = Author)
        @author_model = author_model
    end

    def find_all_authors
        return @author_model.all
    end

    def find_author_by_id(author_id)
        author = @author_model.find_by(id: author_id)
        if author
            return convert_to_dto(author)
        else
            raise ActiveRecord::RecordNotFound, "Author with id #{author_id} not found"
        end
    end

    def create_author(params)
        author = @author_model.new(params)

        if author.save
            return convert_to_dto(author)
        else
            raise StandardError, author.errors.full_messages.join(", ")
        end
    end

    def update_author(author_id, params)
        author = @author_model.find_by(id: author_id)
        if author.update(params)
            return convert_to_dto(author)
        else
            raise StandardError, author.errors.full_messages.join(", ")
        end
    end

    def delete_author(author_id)
        author = @author_model.find_by(id: author_id)
        author.destroy
    end

    private

    def convert_to_dto(author)
        {
            id: author.id,
            name: author.name,
            email: author.email,
            biography: author.biography
        }
    end
end