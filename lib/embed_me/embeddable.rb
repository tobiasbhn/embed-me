module EmbedMe
  module Embeddable
    def set_embeddable!
      if params[:is_embedded].present?
        puts "\nEmbedded Request\n"
      end
    end
  end
end
