require 'test_helper'

class RockPartiesControllerTest < ActionController::TestCase
  setup do
    @rock_party = rock_parties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rock_parties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rock_party" do
    assert_difference('RockParty.count') do
      post :create, rock_party: { eventDate: @rock_party.eventDate, eventHost: @rock_party.eventHost, location: @rock_party.location, name: @rock_party.name }
    end

    assert_redirected_to rock_party_path(assigns(:rock_party))
  end

  test "should show rock_party" do
    get :show, id: @rock_party
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rock_party
    assert_response :success
  end

  test "should update rock_party" do
    put :update, id: @rock_party, rock_party: { eventDate: @rock_party.eventDate, eventHost: @rock_party.eventHost, location: @rock_party.location, name: @rock_party.name }
    assert_redirected_to rock_party_path(assigns(:rock_party))
  end

  test "should destroy rock_party" do
    assert_difference('RockParty.count', -1) do
      delete :destroy, id: @rock_party
    end

    assert_redirected_to rock_parties_path
  end
end
