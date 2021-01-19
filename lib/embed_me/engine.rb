module EmbedMe
  class Engine < ::Rails::Engine
    isolate_namespace EmbedMe

    initializer 'embed_me' do
      ActiveSupport.on_load(:action_controller) do
        before_action :check_embedding!
        helper_method :embedded?

        helper EmbedMe::LinkHelper
        helper EmbedMe::CodeGenerator

        def check_embedding!
          if embedded?
            response.headers.except! 'X-Frame-Options'
          end
        end

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
