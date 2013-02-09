require 'test_helper'

class BillPartsControllerTest < ActionController::TestCase
  setup do
    @bill_part = bill_parts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bill_parts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bill_part" do
    assert_difference('BillPart.count') do
      post :create, :bill_part => @bill_part.attributes
    end

    assert_redirected_to bill_part_path(assigns(:bill_part))
  end

  test "should show bill_part" do
    get :show, :id => @bill_part.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @bill_part.to_param
    assert_response :success
  end

  test "should update bill_part" do
    put :update, :id => @bill_part.to_param, :bill_part => @bill_part.attributes
    assert_redirected_to bill_part_path(assigns(:bill_part))
  end

  test "should destroy bill_part" do
    assert_difference('BillPart.count', -1) do
      delete :destroy, :id => @bill_part.to_param
    end

    assert_redirected_to bill_parts_path
  end
end
