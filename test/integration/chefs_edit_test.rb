require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname:"Maria", email:"maria@example.com", password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname:"John", email:"john@example.com", password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(chefname:"John1", email:"john1@example.com", password: "password", password_confirmation: "password", admin: true)
  end

  test "reject an invalid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: { chefname: " ", email: "maria@example.com" }}
    assert_template 'chefs/edit'
    assert_select 'div.error-message'
  end

  test "accept valid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: { chefname: "mary", email: "mary@example.com" }}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "mary", @chef.chefname
    assert_match "mary@example.com", @chef.email
  end

  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: { chefname: "John3", email: "john3@example.com" }}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "John3", @chef.chefname
    assert_match "john3@example.com", @chef.email
  end

  test "redirect edit attempt by another non-admin user" do
    sign_in_as(@chef2, "password")
    updated_name = "joe"
    updated_email = "joe@example.com"
    patch chef_path(@chef), params: {chef: { chefname: updated_name, email: updated_email }}
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload
    assert_match "Maria", @chef.chefname
    assert_match "maria@example.com", @chef.email
  end
end
