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
    assert_match @recipe.name, response.body
    assert_match @recipe2name, response.body
  end
end
