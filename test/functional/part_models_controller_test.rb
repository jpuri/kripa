require 'test_helper'

class PartModelsControllerTest < ActionController::TestCase
  setup do
    @part_model = part_models(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:part_models)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create part_model" do
    assert_difference('PartModel.count') do
      post :create, :part_model => @part_model.attributes
    end

    assert_redirected_to part_model_path(assigns(:part_model))
  end

  test "should show part_model" do
    get :show, :id => @part_model.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @part_model.to_param
    assert_response :success
  end

  test "should update part_model" do
    put :update, :id => @part_model.to_param, :part_model => @part_model.attributes
    assert_redirected_to part_model_path(assigns(:part_model))
  end

  test "should destroy part_model" do
    assert_difference('PartModel.count', -1) do
      delete :destroy, :id => @part_model.to_param
    end

    assert_redirected_to part_models_path
  end
end
