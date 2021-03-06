module EmbedMe
  module CodeGenerator
    include EmbedMe::LinkHelper

    # Generates some HTML code that allows embedding of the resource of the current request.
    # Creates an iframe element with the embed link as src attribute. HTML options can be
    # customized. Returns a string.
    #
    # ==== Examples
    # Assuming the current request is '/' (root):
    #
    #   embed_code()
    #   # => "<iframe width="560" height="315" src="http://localhost:3000/embed" frameborder="0"
    #       sandbox="">Your Browser does not support HTML iFrame Element.</iframe>"
    #
    #   embed_code(fallback: "")
    #   # => "<iframe width="560" height="315" src="http://localhost:3000/embed" frameborder="0"
    #       sandbox=""></iframe>"
    #
    #   embed_code(width: 760, height: 500)
    #   # => "<iframe width="760" height="500" src="http://localhost:3000/embed" frameborder="0"
    #       sandbox="">Your Browser does not support HTML iFrame Element.</iframe>"
    #
    #   embed_code(width: nil, height: nil)
    #   # => "<iframe src="http://localhost:3000/embed" frameborder="0" sandbox="">Your Browser
    #       does not support HTML iFrame Element.</iframe>"
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

    def embed_frontend(options = {})
      render "embed_me/embed_frontend"
    end
  end
end
