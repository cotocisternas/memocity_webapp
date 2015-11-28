require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:nicolas)
  end

  test "unsuccessfull edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: {name: "", email: "foo@invalid", password: "foo", password_confirmation: "bar"}
    assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "Nico"
    last_name = "Fuenzalida"
    mobile_num = "569123456789"
    email = "foo@bar.com"
    patch user_path(@user), user: { name: name, last_name: last_name, email: email, mobile_num: mobile_num, password: "", password_confirmation: "" }
    assert flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
    assert_equal mobile_num, @user.mobile_num

  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = "Nico Fuenzalida"
    email = "nico@memocity.cl"
    patch user_path(@user), user: {name: name, email: email, password: "", password_confirmation: ""}
    assert_not flash.empty?
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

end
