require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname:"Maria", email:"maria@example.com")
    @recipe = Recipe.create(name:"enfrijoladas", description:"Traditionally, enfrijoladas 
    are made by dipping stale tortillas into leftover frijoles.", chef: @chef)
    @recipe2 = @chef.recipes.build(name:"Iced cafe de olla", description: "Iced Café de Olla
    I love the flavor of orange zest and spices in a café de olla.")
    @recipe2.save
  end

  test "should get recipes index" do
    get recipes_url
    assert_response :success
  end

  test "should get recipes listing" do 
    get recipes_path
    assert_template 'recipes/index'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
  end

  test "should get recipes show" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body 
    assert_match @recipe.description, response.body 
    assert_match @chef.chefname, response.body 
  end

  test "create new valid recipe" do
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = "tacos"
    description_of_recipe = "potato tacos"
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params:{recipe:{name: name_of_recipe,
        description: description_of_recipe}}
    end
    follow_redirect!
    assert_match name_of_recipe, response.body 
    assert_match description_of_recipe, response.body
  end

  test "reject invalid recipe submissions" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: {recipe: {name:" ", description: " "}}
    end
    assert_template 'recipes/new'
    assert_select 'div.error-message'
  end
  
end
