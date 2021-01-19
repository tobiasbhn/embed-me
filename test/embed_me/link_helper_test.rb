require 'test_helper'

module EmbedMe
  class LinkHelperTest < ActionView::TestCase
    test "correct merging of embedding flag" do
      result = merged_embedded(posts_path)
      assert_equal 'posts', result[:controller]
      assert_equal 'index', result[:action]
      assert_equal true, result[:embedded]

      result = merged_embedded(controller: 'posts', action: 'new')
      assert_equal 'posts', result[:controller]
      assert_equal 'new', result[:action]
      assert_equal true, result[:embedded]

      result = merged_embedded(Post.new)
      assert_equal 'posts', result[:controller]
      assert_equal 'index', result[:action]
      assert_equal true, result[:embedded]

      result = merged_embedded(embed_posts_path)
      assert_equal 'posts', result[:controller]
      assert_equal 'index', result[:action]
      assert_equal true, result[:embedded]
    end

    test "return correct availabillity of embedded link" do
      result = embedded_link_available?(private_path)
      assert_equal false, result

      result = embedded_link_available?(root_path)
      assert_equal true, result

      result = embedded_link_available?(posts_path)
      assert_equal true, result

      result = embedded_link_available?(embeddable_path)
      assert_equal true, result

      result = embedded_link_available?(embed_posts_path)
      assert_equal true, result
    end

    test "return correct embeddable link" do
      # TODO
      # How to Test this if request is required
    end

    test "support all link_to call variations" do
      # TODO
    end

    test "embeddable_link_to same result as link_to if not embedded" do
      # TODO
    end
  end
end
