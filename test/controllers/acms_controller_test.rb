require 'test_helper'

class AcmsControllerTest < ActionController::TestCase
  setup do
    @acm = acms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:acms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create acm" do
    assert_difference('Acm.count') do
      post :create, acm: { abstract: @acm.abstract, author: @acm.author, generic_string: @acm.generic_string, link: @acm.link, publisher: @acm.publisher, pubtitle: @acm.pubtitle, pubtype: @acm.pubtype, title: @acm.title }
    end

    assert_redirected_to acm_path(assigns(:acm))
  end

  test "should show acm" do
    get :show, id: @acm
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @acm
    assert_response :success
  end

  test "should update acm" do
    patch :update, id: @acm, acm: { abstract: @acm.abstract, author: @acm.author, generic_string: @acm.generic_string, link: @acm.link, publisher: @acm.publisher, pubtitle: @acm.pubtitle, pubtype: @acm.pubtype, title: @acm.title }
    assert_redirected_to acm_path(assigns(:acm))
  end

  test "should destroy acm" do
    assert_difference('Acm.count', -1) do
      delete :destroy, id: @acm
    end

    assert_redirected_to acms_path
  end
end
