module ActionDispatch::Routing
  class Mapper
    def embeddable
      yield
      scope EmbedMe.scope_name.to_s, as: EmbedMe.scope_name.to_s, embedded: true do
        yield
      end
    end
  end
end
