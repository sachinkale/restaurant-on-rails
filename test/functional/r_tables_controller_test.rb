require 'test_helper'

class RTablesControllerTest < ActionController::TestCase
  setup do
    @r_table = r_tables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:r_tables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create r_table" do
    assert_difference('RTable.count') do
      post :create, :r_table => @r_table.attributes
    end

    assert_redirected_to r_table_path(assigns(:r_table))
  end

  test "should show r_table" do
    get :show, :id => @r_table.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @r_table.to_param
    assert_response :success
  end

  test "should update r_table" do
    put :update, :id => @r_table.to_param, :r_table => @r_table.attributes
    assert_redirected_to r_table_path(assigns(:r_table))
  end

  test "should destroy r_table" do
    assert_difference('RTable.count', -1) do
      delete :destroy, :id => @r_table.to_param
    end

    assert_redirected_to r_tables_path
  end
end
