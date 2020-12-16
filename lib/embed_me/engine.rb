module EmbedMe
  class Engine < ::Rails::Engine
    isolate_namespace EmbedMe

    initializer "embed_me" do
      ActiveSupport.on_load(:action_controller) do
        before_action :check_embedding!

        def default_url_options(options={})
          hash_embed = Hash.new
          hash_embed[EmbedMe.scope_name] = EmbedMe.scope_name.to_s
          hash_normal = Hash.new
          hash_normal[EmbedMe.scope_name] = nil
          params[EmbedMe.scope_name] == EmbedMe.scope_name.to_s ? hash_embed : hash_normal
        end

        def embedded?
          # using path instead of params because path[:embed] != params[:embed] if
          # URL: http://localhost:3000/posts?embed=embed
          path = Rails.application.routes.recognize_path(request.path)
          path[EmbedMe.scope_name] == EmbedMe.scope_name.to_s
        end

        def check_embedding!
          if embedded?
            response.headers.except! 'X-Frame-Options'
          end
        end
      end
    end
  end
end
