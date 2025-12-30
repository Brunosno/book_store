require "test_helper"

class PessoaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pessoa_index_url
    assert_response :success
  end

  test "should get show" do
    get pessoa_show_url
    assert_response :success
  end

  test "should get create" do
    get pessoa_create_url
    assert_response :success
  end

  test "should get update" do
    get pessoa_update_url
    assert_response :success
  end

  test "should get destroy" do
    get pessoa_destroy_url
    assert_response :success
  end
end
