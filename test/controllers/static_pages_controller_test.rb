require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

  def setup
    @base_title = 'Memocity'
  end

  test "should get home" do
    get :home
    assert_response :success
    assert_select "h1", "Memocity"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Ayuda | #{@base_title}"

  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "Acerca | #{@base_title}"
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contacto | #{@base_title}"
  end

end
