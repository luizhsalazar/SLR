require 'test_helper'

class SpringersControllerTest < ActionController::TestCase
  setup do
    @springer = springers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:springers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create springer" do
    assert_difference('Springer.count') do
      post :create, springer: { abstract: @springer.abstract, author: @springer.author, included: @springer.included, link: @springer.link, protocol_id: @springer.protocol_id, publisher: @springer.publisher, pubtitle: @springer.pubtitle, pubtype: @springer.pubtype, selected: @springer.selected, title: @springer.title }
    end

    assert_redirected_to springer_path(assigns(:springer))
  end

  test "should show springer" do
    get :show, id: @springer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @springer
    assert_response :success
  end

  test "should update springer" do
    patch :update, id: @springer, springer: { abstract: @springer.abstract, author: @springer.author, included: @springer.included, link: @springer.link, protocol_id: @springer.protocol_id, publisher: @springer.publisher, pubtitle: @springer.pubtitle, pubtype: @springer.pubtype, selected: @springer.selected, title: @springer.title }
    assert_redirected_to springer_path(assigns(:springer))
  end

  test "should destroy springer" do
    assert_difference('Springer.count', -1) do
      delete :destroy, id: @springer
    end

    assert_redirected_to springers_path
  end
end
