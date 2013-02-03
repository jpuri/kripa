require 'test_helper'

class ModelPricesControllerTest < ActionController::TestCase
  setup do
    @model_price = model_prices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:model_prices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create model_price" do
    assert_difference('ModelPrice.count') do
      post :create, :model_price => @model_price.attributes
    end

    assert_redirected_to model_price_path(assigns(:model_price))
  end

  test "should show model_price" do
    get :show, :id => @model_price.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @model_price.to_param
    assert_response :success
  end

  test "should update model_price" do
    put :update, :id => @model_price.to_param, :model_price => @model_price.attributes
    assert_redirected_to model_price_path(assigns(:model_price))
  end

  test "should destroy model_price" do
    assert_difference('ModelPrice.count', -1) do
      delete :destroy, :id => @model_price.to_param
    end

    assert_redirected_to model_prices_path
  end
end
