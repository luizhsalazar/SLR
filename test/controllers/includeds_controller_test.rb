require 'test_helper'

class IncludedsControllerTest < ActionController::TestCase
  setup do
    @included = includeds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:includeds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create included" do
    assert_difference('Included.count') do
      post :create, included: { author: @included.author, included: @included.included, protocol_id: @included.protocol_id, pubtitle: @included.pubtitle, title: @included.title }
    end

    assert_redirected_to included_path(assigns(:included))
  end

  test "should show included" do
    get :show, id: @included
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @included
    assert_response :success
  end

  test "should update included" do
    patch :update, id: @included, included: { author: @included.author, included: @included.included, protocol_id: @included.protocol_id, pubtitle: @included.pubtitle, title: @included.title }
    assert_redirected_to included_path(assigns(:included))
  end

  test "should destroy included" do
    assert_difference('Included.count', -1) do
      delete :destroy, id: @included
    end

    assert_redirected_to includeds_path
  end
end
