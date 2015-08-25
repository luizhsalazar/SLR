require 'test_helper'

class ScidirsControllerTest < ActionController::TestCase
  setup do
    @scidir = scidirs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scidirs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scidir" do
    assert_difference('Scidir.count') do
      post :create, scidir: { abstract: @scidir.abstract, author: @scidir.author, generic_string: @scidir.generic_string, link: @scidir.link, publisher: @scidir.publisher, pubtitle: @scidir.pubtitle, pubtype: @scidir.pubtype, title: @scidir.title }
    end

    assert_redirected_to scidir_path(assigns(:scidir))
  end

  test "should show scidir" do
    get :show, id: @scidir
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scidir
    assert_response :success
  end

  test "should update scidir" do
    patch :update, id: @scidir, scidir: { abstract: @scidir.abstract, author: @scidir.author, generic_string: @scidir.generic_string, link: @scidir.link, publisher: @scidir.publisher, pubtitle: @scidir.pubtitle, pubtype: @scidir.pubtype, title: @scidir.title }
    assert_redirected_to scidir_path(assigns(:scidir))
  end

  test "should destroy scidir" do
    assert_difference('Scidir.count', -1) do
      delete :destroy, id: @scidir
    end

    assert_redirected_to scidirs_path
  end
end
