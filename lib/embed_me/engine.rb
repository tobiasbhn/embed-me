module EmbedMe
  class Engine < ::Rails::Engine
    isolate_namespace EmbedMe

    initializer "embed_me" do
      ActiveSupport.on_load(:action_controller) do
          include EmbedMe::Embeddable
          before_action :set_embeddable!
      end
    end
  end
end
