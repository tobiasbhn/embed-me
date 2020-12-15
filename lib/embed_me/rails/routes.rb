module ActionDispatch::Routing
  class Mapper
    def embeddable
      yield
      scope path: "/#{EmbedMe.scope_name}", as: EmbedMe.scope_name, is_embedded: true do
        yield
      end
    end
  end
end
