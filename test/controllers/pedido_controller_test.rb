require "test_helper"

class PedidoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pedido_index_url
    assert_response :success
  end

  test "should get show" do
    get pedido_show_url
    assert_response :success
  end

  test "should get create" do
    get pedido_create_url
    assert_response :success
  end

  test "should get update" do
    get pedido_update_url
    assert_response :success
  end

  test "should get destroy" do
    get pedido_destroy_url
    assert_response :success
  end
end
