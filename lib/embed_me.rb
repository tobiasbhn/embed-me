require "embed_me/engine"
require "embed_me/link_helper"
require "embed_me/code_generator"
require "embed_me/rails/routes"

module EmbedMe
  # defines a scoped route under which the embedded content can be found
  mattr_accessor :scope_name, default: :embed
end
