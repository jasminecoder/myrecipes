require 'test_helper'

class ChefsSignupTest < ActionDispatch::IntegrationTest

  def setup 
    @chef = Chef.create!(chefname:"Maria", email:"maria@example.com", password: "password", password_confirmation: "password")
  end

  test "should get sign up path" do
    get signup_path
    assert_response :success
  end

  test "reject an invalid signup" do
    get signup_path
    assert_no_difference "Chef.count" do
      post chefs_path, params: {chef: { chefname: " ", email: " ", password: "password", 
                                password_confirmation: " "}}
    end
    assert_template 'chefs/new'
    assert_select 'div.error-message'
  end

  test "accept valid signup" do
    get signup_path
    assert_difference 'Chef.count', 1 do
      post chefs_path, params:{chef:{chefname: "nenene",
        email: "nenene@example.com", password: "password", password_confirmation: "password"}}
    end
    follow_redirect!
    assert_template 'chefs/show'
    assert_not flash.empty?
  end
 
end
