require "test_helper"

class UsuarioControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get usuario_index_url
    assert_response :success
  end

  test "should get show" do
    get usuario_show_url
    assert_response :success
  end

  test "should get create" do
    get usuario_create_url
    assert_response :success
  end

  test "should get update" do
    get usuario_update_url
    assert_response :success
  end

  test "should get destroy" do
    get usuario_destroy_url
    assert_response :success
  end
end
