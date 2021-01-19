module EmbedMe
  module LinkHelper
    def embeddable_link_to(name = nil, options = nil, html_options = {}, &block)
      if embedded? && embedded_link_available?(options)
        # generate embedded link if possible
        merged_params = merged_embedded(options)
        link_to(name, merged_params, html_options, &block)
      elsif embedded?
        # open link in new tab if no embedded link available
        html_options.merge!({target: "_blank"})
        link_to(name, options, html_options, &block)
      else
        # normal behaviour if not embedded
        link_to(name, options, html_options, &block)
      end
    end

    def embedded_link_available?(url_data)
      merged_params = merged_embedded(url_data)

      # test if embedded flag is in path or url parameter
      embedded_link = url_for(merged_params)
      embedded_link_params = Rails.application.routes.recognize_path(embedded_link)
      embedded_link_params[:embedded].present?
    end

    def merged_embedded(url_data)
      # extract link parameters
      original_link = url_for(url_data)
      original_link_params = Rails.application.routes.recognize_path(original_link)

      # merge embedded flag
      merged_params = original_link_params.merge({embedded: true})
      merged_params
    end

    def current_page_embed_url
      # return if no link available
      return nil unless embedded_link_available?(request.path)

      # get current link
      current_page = merged_embedded(request.path)
      current_page.merge!({only_path: false})
      url_for(current_page)
    end
  end
end
