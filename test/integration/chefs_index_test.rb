require 'test_helper'

class ChefsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname:"Maria", email:"maria@example.com", password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname:"lilian", email:"lilian@example.com", password: "password", password_confirmation: "password")
  end
  
  test "should get chefs listing" do
    get chefs_path
    assert_template 'chefs/index'
    assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.chefname
  end

  test "should delete chef" do
    get chefs_path
    assert_template 'chefs/index'
    sign_in_as(@chef2, "password")
    assert_difference 'Chef.count', -1 do
      delete chef_path(@chef2)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end

end