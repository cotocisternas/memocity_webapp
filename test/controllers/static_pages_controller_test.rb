require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

  def setup
    @base_title = 'Memocity'
  end

  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Ayuda"

  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "Acerca"
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contacto"
  end

end
