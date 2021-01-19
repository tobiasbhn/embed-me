require 'test_helper'

module EmbedMe
  class EngineTest < ActionDispatch::IntegrationTest
    test "should return correct embedding status" do
      get private_url
      assert_response :success
      assert_equal false, @controller.embedded?

      get root_url
      assert_response :success
      assert_equal false, @controller.embedded?

      get posts_url
      assert_response :success
      assert_equal false, @controller.embedded?

      get embeddable_url
      assert_response :success
      assert_equal false, @controller.embedded?

      get embed_root_url
      assert_response :success
      assert_equal true, @controller.embedded?

      get embed_posts_url
      assert_response :success
      assert_equal true, @controller.embedded?

      get embed_embeddable_url
      assert_response :success
      assert_equal true, @controller.embedded?
    end

    test "should ignore url parameters on embedding status" do
      get private_url, params: { embedded: true }
      assert_response :success
      assert_equal false, @controller.embedded?

      get private_url, params: { embedded: false }
      assert_response :success
      assert_equal false, @controller.embedded?

      get embed_embeddable_url, params: { embedded: true }
      assert_response :success
      assert_equal true, @controller.embedded?

      get embed_embeddable_url, params: { embedded: false }
      assert_response :success
      assert_equal true, @controller.embedded?

      get "#{private_url}?embedded=true"
      assert_response :success
      assert_equal false, @controller.embedded?

      get "#{embed_embeddable_url}?embedded=false"
      assert_response :success
      assert_equal true, @controller.embedded?
    end

    test "should return correct response for wrong routes" do
      assert_raises(ActionController::RoutingError) do
        get "/embed/private"
        assert_response :error
      end
    end

    test "should manage x-frame-options correctly" do
      get private_url
      assert_response :success
      assert_equal "SAMEORIGIN", @response.headers["X-Frame-Options"]

      get root_url
      assert_response :success
      assert_equal "SAMEORIGIN", @response.headers["X-Frame-Options"]

      get posts_url
      assert_response :success
      assert_equal "SAMEORIGIN", @response.headers["X-Frame-Options"]

      get embeddable_url
      assert_response :success
      assert_equal "SAMEORIGIN", @response.headers["X-Frame-Options"]

      get embed_embeddable_url
      assert_response :success
      assert_nil @response.headers["X-Frame-Options"]

      get embed_root_url
      assert_response :success
      assert_nil @response.headers["X-Frame-Options"]

      get embed_posts_url
      assert_response :success
      assert_nil @response.headers["X-Frame-Options"]
    end
  end
end
