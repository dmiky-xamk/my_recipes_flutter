import 'package:my_recipes/src/features/recipes/domain/directions.dart';
import 'package:my_recipes/src/features/recipes/domain/ingredient.dart';
import 'package:my_recipes/src/features/recipes/domain/recipe.dart';
import 'package:my_recipes/src/features/shopping_list/domain/shopping_list_ingredient.dart';

final kTestRecipes = [
  Recipe(
    id: "123",
    name: "Pannukakku",
    image: "",
    description: "Nopea ja maukas",
    ingredients: [
      Ingredient(
        amount: "1",
        unit: "l",
        name: "maitoa",
      ),
      Ingredient(
        amount: "4",
        unit: "dl",
        name: "vehnäjauhoja",
      ),
      Ingredient(
        amount: "1",
        unit: "kpl",
        name: "kananmunia",
      ),
    ],
    directions: [
      Direction(
        step: "Sekoita kuivat aineet",
      ),
      Direction(
        step: "Lisää sekoittaen taikinaan",
      ),
      Direction(
        step: "Paista uunin keskitasolla noin 30min",
      ),
    ],
  ),
  Recipe(
    id: "124",
    name: "Kaurapuuro",
    image: "",
    description: "Helppo aamulla",
    ingredients: [
      Ingredient(
        amount: "2",
        unit: "dl",
        name: "vettä",
      ),
      Ingredient(
        amount: "1",
        unit: "dl",
        name: "kauraryynejä",
      ),
      Ingredient(
        amount: "1",
        unit: "tl",
        name: "suolaa",
      ),
    ],
    directions: [
      Direction(
        step: "Kiehauta vesi",
      ),
      Direction(
        step: "Lisää veteen ryynit sekä suola",
      ),
      Direction(
        step: "Anna kiehua noin 10min kunnes rakenne on mieleinen",
      ),
    ],
  ),
  Recipe(
    id: "124",
    name: "Kaurapuuro",
    image: "",
    description: "Helppo aamulla",
    ingredients: [
      Ingredient(
        amount: "2",
        unit: "dl",
        name: "vettä",
      ),
      Ingredient(
        amount: "1",
        unit: "dl",
        name: "kauraryynejä",
      ),
      Ingredient(
        amount: "1",
        unit: "tl",
        name: "suolaa",
      ),
    ],
    directions: [
      Direction(
        step: "Kiehauta vesi",
      ),
      Direction(
        step: "Lisää veteen ryynit sekä suola",
      ),
      Direction(
        step: "Anna kiehua noin 10min kunnes rakenne on mieleinen",
      ),
    ],
  ),
  Recipe(
    id: "124",
    name: "Kaurapuuro",
    image: "",
    description: "Helppo aamulla",
    ingredients: [
      Ingredient(
        amount: "2",
        unit: "dl",
        name: "vettä",
      ),
      Ingredient(
        amount: "1",
        unit: "dl",
        name: "kauraryynejä",
      ),
      Ingredient(
        amount: "1",
        unit: "tl",
        name: "suolaa",
      ),
    ],
    directions: [
      Direction(
        step: "Kiehauta vesi",
      ),
      Direction(
        step: "Lisää veteen ryynit sekä suola",
      ),
      Direction(
        step: "Anna kiehua noin 10min kunnes rakenne on mieleinen",
      ),
    ],
  ),
  Recipe(
    id: "124",
    name: "Kaurapuuro",
    image: "",
    description: "Helppo aamulla",
    ingredients: [
      Ingredient(
        amount: "2",
        unit: "dl",
        name: "vettä",
      ),
      Ingredient(
        amount: "1",
        unit: "dl",
        name: "kauraryynejä",
      ),
      Ingredient(
        amount: "1",
        unit: "tl",
        name: "suolaa",
      ),
    ],
    directions: [
      Direction(
        step: "Kiehauta vesi",
      ),
      Direction(
        step: "Lisää veteen ryynit sekä suola",
      ),
      Direction(
        step: "Anna kiehua noin 10min kunnes rakenne on mieleinen",
      ),
    ],
  ),
  Recipe(
    id: "124",
    name: "Kaurapuuro",
    image: "",
    description: "Helppo aamulla",
    ingredients: [
      Ingredient(
        amount: "2",
        unit: "dl",
        name: "vettä",
      ),
      Ingredient(
        amount: "1",
        unit: "dl",
        name: "kauraryynejä",
      ),
      Ingredient(
        amount: "1",
        unit: "tl",
        name: "suolaa",
      ),
    ],
    directions: [
      Direction(
        step: "Kiehauta vesi",
      ),
      Direction(
        step: "Lisää veteen ryynit sekä suola",
      ),
      Direction(
        step: "Anna kiehua noin 10min kunnes rakenne on mieleinen",
      ),
    ],
  ),
  Recipe(
    id: "124",
    name: "Kaurapuuro",
    image: "",
    description: "Helppo aamulla",
    ingredients: [
      Ingredient(
        amount: "2",
        unit: "dl",
        name: "vettä",
      ),
      Ingredient(
        amount: "1",
        unit: "dl",
        name: "kauraryynejä",
      ),
      Ingredient(
        amount: "1",
        unit: "tl",
        name: "suolaa",
      ),
    ],
    directions: [
      Direction(
        step: "Kiehauta vesi",
      ),
      Direction(
        step: "Lisää veteen ryynit sekä suola",
      ),
      Direction(
        step: "Anna kiehua noin 10min kunnes rakenne on mieleinen",
      ),
    ],
  ),
  Recipe(
    id: "124",
    name: "Kaurapuuro",
    image: "",
    description: "Helppo aamulla",
    ingredients: [
      Ingredient(
        amount: "2",
        unit: "dl",
        name: "vettä",
      ),
      Ingredient(
        amount: "1",
        unit: "dl",
        name: "kauraryynejä",
      ),
      Ingredient(
        amount: "1",
        unit: "tl",
        name: "suolaa",
      ),
    ],
    directions: [
      Direction(
        step: "Kiehauta vesi",
      ),
      Direction(
        step: "Lisää veteen ryynit sekä suola",
      ),
      Direction(
        step: "Anna kiehua noin 10min kunnes rakenne on mieleinen",
      ),
    ],
  ),
  Recipe(
    id: "124",
    name: "Kaurapuuro",
    image: "",
    description: "Helppo aamulla",
    ingredients: [
      Ingredient(
        amount: "2",
        unit: "dl",
        name: "vettä",
      ),
      Ingredient(
        amount: "1",
        unit: "dl",
        name: "kauraryynejä",
      ),
      Ingredient(
        amount: "1",
        unit: "tl",
        name: "suolaa",
      ),
    ],
    directions: [
      Direction(
        step: "Kiehauta vesi",
      ),
      Direction(
        step: "Lisää veteen ryynit sekä suola",
      ),
      Direction(
        step: "Anna kiehua noin 10min kunnes rakenne on mieleinen",
      ),
    ],
  ),
];

final kTestShoppingListIngredients = [
  const ShoppingListIngredient(
    id: 1,
    ingredientName: "TestiTuote",
    isSelected: false,
  ),
  const ShoppingListIngredient(
    id: 2,
    ingredientName: "TestiTuote2",
    isSelected: false,
  ),
  const ShoppingListIngredient(
    id: 3,
    recipeId: "123",
    ingredientName: "TestiTuote3",
    isSelected: false,
  ),
  const ShoppingListIngredient(
    id: 4,
    recipeId: "123",
    ingredientName: "TestiTuote4",
    isSelected: false,
  ),
  const ShoppingListIngredient(
    id: 5,
    ingredientName: "TestiTuote5",
    isSelected: false,
  ),
  const ShoppingListIngredient(
    id: 6,
    recipeId: "123",
    ingredientName: "TestiTuote6",
    isSelected: false,
  ),
];
