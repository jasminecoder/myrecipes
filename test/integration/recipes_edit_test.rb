require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname:"Maria", email:"maria@example.com", password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name:"enfrijoladas", description:"Traditionally, enfrijoladas 
    are made by dipping stale tortillas into leftover frijoles.", chef: @chef)
  end

  test "reject invalid recipe update" do
    sign_in_as(@chef, "password")
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: {recipe: {name: " ", description: "some description"}}
    assert_template 'recipes/edit'
    assert_select 'div.error-message'
  end

  test "succesfully edit a recipe" do
    sign_in_as(@chef, "password")
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    updated_name = "Updated Recipe Name"
    updated_description = "updated recipe description"
    patch recipe_path(@recipe), params: {recipe: {name: updated_name, description: updated_description }}
    assert_redirected_to @recipe
    assert_not flash.empty? 
    @recipe.reload
    assert_match updated_name, @recipe.name 
    assert_match updated_description, @recipe.description 
  end


end
