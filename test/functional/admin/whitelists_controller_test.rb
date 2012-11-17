require 'test_helper'

class Admin::WhitelistsControllerTest < ActionController::TestCase
  setup do
    @admin_whitelist = admin_whitelists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_whitelists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_whitelist" do
    assert_difference('Admin::Whitelist.count') do
      post :create, admin_whitelist: { email: @admin_whitelist.email }
    end

    assert_redirected_to admin_whitelist_path(assigns(:admin_whitelist))
  end

  test "should show admin_whitelist" do
    get :show, id: @admin_whitelist
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_whitelist
    assert_response :success
  end

  test "should update admin_whitelist" do
    put :update, id: @admin_whitelist, admin_whitelist: { email: @admin_whitelist.email }
    assert_redirected_to admin_whitelist_path(assigns(:admin_whitelist))
  end

  test "should destroy admin_whitelist" do
    assert_difference('Admin::Whitelist.count', -1) do
      delete :destroy, id: @admin_whitelist
    end

    assert_redirected_to admin_whitelists_path
  end
end
