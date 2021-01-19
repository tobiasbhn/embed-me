module EmbedMe
  module LinkHelper
    # Creates an HTML link element. To do this, it checks whether the request comes
    # from an embedded resource and whether there is an embedded version of the
    # requested route. If both are true, a link is generated that redirects to the
    # embedded version. If no embedded version of the route exists, but the request
    # is within an embedding, the link will be opened in a new tab. If the request
    # is not embedded, the link is created as normal.
    #
    # ==== Examples
    # Assuming the current request is NOT embedded, then:
    #
    #   embeddable_link_to("Not Embeddable", private_path)
    #   # => <a href="/private">Not Embeddable</a>
    #
    #   embeddable_link_to("Embeddable", embeddable_path)
    #   # => <a href="/embeddable">Embeddable</a>
    #
    # Assuming the current request IS embedded, then:
    #
    #   embeddable_link_to("Not Embeddable", private_path)
    #   # => <a target="_blank" href="/private">Not Embeddable</a>
    #
    #   embeddable_link_to("Embeddable", embeddable_path)
    #   # => <a href="/embed/embeddable">Embeddable</a>
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

    # Checks whether there is an embedded version of a specific route.
    # Returns a boolean Value.
    #
    # ==== Examples
    #
    #   embedded_link_available?(private_path)
    #   # => false
    #
    #   embedded_link_available?(root_path)
    #   # => true
    #
    #   embedded_link_available?(embed_posts_path)
    #   # => true
    def embedded_link_available?(url_data)
      merged_params = merged_embedded(url_data)

      # test if embedded flag is in path or url parameter
      embedded_link = url_for(merged_params)
      embedded_link_params = Rails.application.routes.recognize_path(embedded_link)
      embedded_link_params[:embedded].present?
    end

    # Extracts the Route generation parameters and merges the embedded value,
    # which is used to generate embedding specific URLs. Returns a hash containing
    # url generation data.
    #
    # ==== Examples
    #
    #   merged_embedded(posts_path)
    #   # => {:controller=>"posts", :action=>"index", :embedded=>true}
    #
    #   merged_embedded(controller: "posts", action: "index")
    #   # => {:controller=>"posts", :action=>"index", :embedded=>true}
    def merged_embedded(url_data)
      # extract link parameters
      original_link = url_for(url_data)
      original_link_params = Rails.application.routes.recognize_path(original_link)

      # merge embedded flag
      merged_params = original_link_params.merge({embedded: true})
      merged_params
    end

    # Checks if there is an embedded version for the current request. If this is the
    # case, the link to the embedded version is returned. If there is no embedded
    # version, nil is returned.
    #
    # ==== Examples
    # Assuming the current request IS embeddable:
    # (E.g. root_path)
    #
    #   current_page_embed_url()
    #   # => http://localhost:3000/embed
    #
    # (E.g. post_path(id: 1))
    #
    #   current_page_embed_url()
    #   # => http://localhost:3000/embed/posts/1
    #
    # Assuming the current request is NOT embeddable:
    # (E.g. private_path)
    #
    #   current_page_embed_url()
    #   # => nil
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
