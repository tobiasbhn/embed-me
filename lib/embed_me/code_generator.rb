module EmbedMe
  module CodeGenerator
    include EmbedMe::LinkHelper

    def embed_code(options = {})
      # get embed link or return if not present
      embed_url = current_page_embed_url
      return nil unless embed_url.present?

      # set values
      fallback = options.delete(:fallback) || "Your Browser does not support HTML iFrame Element."
      default_html = {width: 560, height: 315, src: embed_url, frameborder: 0, sandbox: ''}
      default_html.merge!(options)

      # create element
      element = content_tag(:iframe, fallback, default_html)
      "#{element}"
    end
  end
end
