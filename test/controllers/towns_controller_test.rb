require 'test_helper'

class TownsControllerTest < ActionController::TestCase
  setup do
    @town = towns(:one)
    @inexisting = towns(:inexisting)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:towns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create town" do
    VCR.use_cassette("new_town") do
      assert_difference('Town.count') do
        post :create, town: { nom: @town.nom }
      end
    end

    assert_redirected_to town_path(assigns(:town))
  end

  test "should fail if town does not exist" do
    VCR.use_cassette("inexisting_town") do
      assert_no_difference('Town.count') do
        post :create, town: { nom: @inexisting.nom }
      end
    end
    
    assert_response :success
  end
  
  test "should show town" do
    VCR.use_cassette("show_town") do
      get :show, id: @town
      assert_response :success
    end
  end

  test "should get edit" do
    get :edit, id: @town
    assert_response :success
  end

  test "should update town" do
    VCR.use_cassette("update_town") do
      patch :update, id: @town, town: { latitude: @town.latitude, longitude: @town.longitude, nom: @town.nom }
      assert_redirected_to town_path(assigns(:town))
    end
  end

  test "should destroy town" do
    assert_difference('Town.count', -1) do
      delete :destroy, id: @town
    end

    assert_redirected_to towns_path
  end
end
