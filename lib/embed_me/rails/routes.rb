module ActionDispatch::Routing
  class Mapper
    # Enables the definition of resources that should be embeddable. The routes defined
    # within the block are transferred to the application in duplicated form. Once
    # normally, as they would always work, and once under an embed scope. The name of
    # the scope can be set in config (default: 'embed').
    #
    # ==== Examples
    # Assuming the following route definition:
    #
    #   get 'path_private', to: 'application#path_private'
    #   embeddable do
    #     get 'path_embed', to: 'application#path_embed'
    #   end
    #
    # will produce following routes:
    #
    #   path_private     GET   /path_private(.:format)        application#path_private
    #   path_embed       GET   /path_embed(.:format)          application#path_embed
    #   embed_path_embed GET   /embed/path_embed(.:format)    application#path_embed {:embedded=>true}
    def embeddable
      yield
      scope EmbedMe.scope_name.to_s, as: EmbedMe.scope_name.to_s, embedded: true do
        yield
      end
    end
  end
end
