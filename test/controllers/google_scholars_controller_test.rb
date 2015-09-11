require 'test_helper'

class GoogleScholarsControllerTest < ActionController::TestCase
  setup do
    @google_scholar = google_scholars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:google_scholars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create google_scholar" do
    assert_difference('GoogleScholar.count') do
      post :create, google_scholar: { abstract: @google_scholar.abstract, author: @google_scholar.author, included: @google_scholar.included, link: @google_scholar.link, protocol_id: @google_scholar.protocol_id, publisher: @google_scholar.publisher, pubtitle: @google_scholar.pubtitle, pubtype: @google_scholar.pubtype, selected: @google_scholar.selected, title: @google_scholar.title }
    end

    assert_redirected_to google_scholar_path(assigns(:google_scholar))
  end

  test "should show google_scholar" do
    get :show, id: @google_scholar
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @google_scholar
    assert_response :success
  end

  test "should update google_scholar" do
    patch :update, id: @google_scholar, google_scholar: { abstract: @google_scholar.abstract, author: @google_scholar.author, included: @google_scholar.included, link: @google_scholar.link, protocol_id: @google_scholar.protocol_id, publisher: @google_scholar.publisher, pubtitle: @google_scholar.pubtitle, pubtype: @google_scholar.pubtype, selected: @google_scholar.selected, title: @google_scholar.title }
    assert_redirected_to google_scholar_path(assigns(:google_scholar))
  end

  test "should destroy google_scholar" do
    assert_difference('GoogleScholar.count', -1) do
      delete :destroy, id: @google_scholar
    end

    assert_redirected_to google_scholars_path
  end
end
