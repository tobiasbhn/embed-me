module EmbedMe
  class Engine < ::Rails::Engine
    isolate_namespace EmbedMe

    initializer 'embed_me' do
      ActiveSupport.on_load(:action_controller) do
        before_action :check_embedding!
        helper_method :embedded?
        helper EmbedMe::LinkHelper
        helper EmbedMe::CodeGenerator

        # Checks if the request comes from an embedded resource and removes the
        # X-Frame-Options Header so that the content can be opened in a frame.
        # If the request comes from a resource that is not intended to be embedded,
        # the value remains, so that the frame blocks the rendering.
        def check_embedding!
          if embedded?
            response.headers.except! 'X-Frame-Options'
          end
        end

        # Checks the path of the request for the existence of the embedded parameter,
        # which is specified by the routes. If this value is available, the resource
        # may be embedded. If the value is not available, the resource must not be
        # embedded. URL parameters remain ignored. Returns a boolean value.
        def embedded?
          # using path instead of params because path[:embed] != params[:embed] if
          # URL: http://localhost:3000/posts?embed=embed
          path = Rails.application.routes.recognize_path(request.path)
          path[:embedded].present?
        end
      end
    end
  end
end
