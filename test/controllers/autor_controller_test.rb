require "test_helper"

class AutorControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get autor_index_url
    assert_response :success
  end

  test "should get show" do
    get autor_show_url
    assert_response :success
  end

  test "should get create" do
    get autor_create_url
    assert_response :success
  end

  test "should get update" do
    get autor_update_url
    assert_response :success
  end

  test "should get destroy" do
    get autor_destroy_url
    assert_response :success
  end
end
