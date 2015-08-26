require 'test_helper'

class ScopusControllerTest < ActionController::TestCase
  setup do
    @scopu = scopus(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scopus)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scopu" do
    assert_difference('Scopu.count') do
      post :create, scopu: { abstract: @scopu.abstract, author: @scopu.author, link: @scopu.link, publisher: @scopu.publisher, pubtitle: @scopu.pubtitle, pubtype: @scopu.pubtype, title: @scopu.title }
    end

    assert_redirected_to scopu_path(assigns(:scopu))
  end

  test "should show scopu" do
    get :show, id: @scopu
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scopu
    assert_response :success
  end

  test "should update scopu" do
    patch :update, id: @scopu, scopu: { abstract: @scopu.abstract, author: @scopu.author, link: @scopu.link, publisher: @scopu.publisher, pubtitle: @scopu.pubtitle, pubtype: @scopu.pubtype, title: @scopu.title }
    assert_redirected_to scopu_path(assigns(:scopu))
  end

  test "should destroy scopu" do
    assert_difference('Scopu.count', -1) do
      delete :destroy, id: @scopu
    end

    assert_redirected_to scopus_path
  end
end
