module ActionDispatch::Routing
  class Mapper
    def embeddable
      scope "(:#{EmbedMe.scope_name.to_s})", embed: /#{EmbedMe.scope_name.to_s}/ do
        yield
      end
    end
  end
end
