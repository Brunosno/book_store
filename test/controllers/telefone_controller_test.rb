require "test_helper"

class TelefoneControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get telefone_index_url
    assert_response :success
  end

  test "should get show" do
    get telefone_show_url
    assert_response :success
  end

  test "should get create" do
    get telefone_create_url
    assert_response :success
  end

  test "should get update" do
    get telefone_update_url
    assert_response :success
  end

  test "should get destroy" do
    get telefone_destroy_url
    assert_response :success
  end
end
