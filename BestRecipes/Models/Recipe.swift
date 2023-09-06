//
//  Recipe.swift
//  BestRecipes
//
//  Created by Илья Шаповалов on 27.08.2023.
//

import Foundation

/*
 {
      "cheap": false,
      "veryPopular": false,
      "preparationMinutes": -1,
      "cookingMinutes": -1,
      "aggregateLikes": 2,
      "healthScore": 0,
      "creditsText": "Foodista.com вЂ“ The Cooking Encyclopedia Everyone Can Edit",
      "license": "CC BY 3.0",
      "sourceName": "Foodista",
      "pricePerServing": 10.72,
      "extendedIngredients": [•],
      "id": 665537,
      "title": "Yoghurt Honey Madeleines",
      "readyInMinutes": 45,
      "servings": 15,
      "sourceUrl": "https://www.foodista.com/recipe/ZRS4JSSP/yoghurt-honey-madeleines",
      "image": "https://spoonacular.com/recipeImages/665537-556x370.jpg",
      "imageType": "jpg",
      "summary": "Yoghurt Honey Madeleines is a <b>lacto ovo vegetarian</b> dessert. For <b>11 cents per serving</b>, this recipe <b>covers 2%</b> of your daily requirements of vitamins and minerals. One serving contains <b>81 calories</b>, <b>1g of protein</b>, and <b>4g of fat</b>. This recipe serves 15. A mixture of egg, natural yoghurt, sugar, and a handful of other ingredients are all it takes to make this recipe so tasty. Not a lot of people made this recipe, and 2 would say it hit the spot. From preparation to the plate, this recipe takes roughly <b>45 minutes</b>. It is brought to you by Foodista. All things considered, we decided this recipe <b>deserves a spoonacular score of 9%</b>. This score is very bad (but still fixable). <a href="https: //spoonacular.com/recipes/yoghurt-honey-madeleines-1220817">Yoghurt Honey Madeleines</a>, <a href="https: //spoonacular.com/recipes/honey-madeleines-79834">Honey Madeleines</a>, and <a href="https: //spoonacular.com/recipes/honey-almond-madeleines-308414">Honey-Almond Madeleines</a> are very similar to this recipe.",
      "cuisines": [],
      "dishTypes": [•],
      "diets": [•],
      "occasions": [],
      "instructions": "Grease mould with some soft butter and set aside.\nGently whisk egg, then add in sugar and honey into it. Whisk till sugar dissolved.\nAdd in natural yoghurt and whisk vigourously till batter becomes foamy.\nThen gradually add in sifted flour and baking powder into batter mix till combined and becomes a thick paste.\nLastly add in melted butter in two batches and mix well.\nScoop batter into mould with a spoon.\nBake at preheated oven 180C for about 12 minutes or skewer inserted comes out clean.\nRemove Madeleines from mould and place on wire rack to cool.",
      "analyzedInstructions": [•],
      "originalId": null,
      "spoonacularSourceUrl": "https://spoonacular.com/yoghurt-honey-madeleines-665537"
    }
 */

/// Модель рецепта
struct Recipe: Decodable, Hashable {
    /// Уникальный id рецепта
    let id: String
    
    /// Заголовок рецепта
    let title: String
    
    /// title автора
    let sourceName: String?
    
    /// URL-ссылка на картинку рецепта
    let image: String
    
    /// Краткое описание
    let summary: String?
    
    /// Список ингредиентов в рецепте
    let extendedIngredients: [Ingredient]?
    
}
