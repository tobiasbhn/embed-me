module EmbedMe # :nodoc: all
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
