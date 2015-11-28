require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Nico", last_name: "Fuenzalida", email: "nico@memocity.cl", mobile_num: "5691234567", city: "Santiago", country: "Chile", address: "Los ejemplos 123", birth_date: nil, password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?, "Exist some errors, please check."
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "last name should be present" do
    @user.last_name = ""
    assert_not @user.valid?
  end

  test "mobile number should be present" do
    @user.mobile_num = ""
    assert_not @user.valid?
  end

  test "country should be present" do
    @user.country = ""
    assert_not @user.valid?
  end

  test "city should be present" do
    @user.city = ""
    assert_not @user.valid?
  end

  #Test length of inputs

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be to long" do
    @user.email = "a" * 244 + "@memocity.cl"
  end

  test "last name should not to bee long" do
    @user.last_name = "a" * 51
    assert_not @user.valid?
  end

  test "mobile number should not to bee long" do
    @user.mobile_num = "a" * 15
    assert_not @user.valid?
  end

  test "country name should not to bee long" do
    @user.last_name = "a" * 30
    assert_not @user.valid?
  end

  test "city name should not to bee long" do
    @user.last_name = "a" * 30
    assert_not @user.valid?
  end

  #Email and mobile number validation must be valid

  test "email validation should rejectd invalid address" do
    valid_addresses = %w[nico01f@memocity.cl nico01f@memocity.cl NICO01f@memocity.cl]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect}, Write some valid email address."
    end
  end

  test "email must be uniqueness" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "phone number validation rejected invalid phone" do
    valid_phone_numbers = %w[56964257820]
    valid_phone_numbers.each do |valid_phone_number|
      @user.mobile_num = valid_phone_number
      assert @user.valid?, "#{valid_phone_number.inspect}. Write some valid phone number."
    end
  end

  #Validation of password digest
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

end
