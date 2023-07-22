import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/api/api.dart';
import 'package:my_recipes/src/api/api_error_response.dart';
import 'package:my_recipes/src/features/recipes/domain/recipe.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/recipe_form_model.dart';

class RecipesRepository {
  RecipesRepository({required this.api});
  final RestClient _client = RestClient();
  final RecipesAPI api;

  Future<List<Recipe>> fetchRecipesList2() async {
    final uri = api.recipes;
    final recipes1 = await _client.fetchData(
      uri: uri,
      parser: (data) {
        final recs = jsonDecode(data);
        debugPrint("recs: $recs");
        debugPrint("data: $data");

        final recipes =
            recs.map((json) => Recipe.fromJson(json)).toList().cast<Recipe>();

        return recipes;
      },
    );

    debugPrint("Recipes: $recipes1");

    return recipes1;
  }

  Future<Recipe> fetchRecipe2(String id) async {
    final uri = api.recipe(id);
    return await _client.fetchData(
      uri: uri,
      parser: (data) => Recipe.fromJson(
        jsonDecode(data),
      ),
      errorParser: (data) => throw ApiErrorResponse.fromJson(data),
    );
  }

  Future<Recipe> updateRecipe({required RecipeFormModel recipe}) async {
    final uri = api.recipe(recipe.id!);
    return await _client.putData(
      uri: uri,
      body: recipe.toJson(),
      parser: (data) => Recipe.fromJson(
        jsonDecode(data),
      ),
      errorParser: (data) => throw ApiErrorResponse.fromJson(data),
    );
  }

  Future<Recipe> createRecipe({required RecipeFormModel recipe}) async {
    final uri = api.recipes;
    return await _client.postData(
      uri: uri,
      body: recipe.toJson(),
      parser: (data) => Recipe.fromJson(
        jsonDecode(data),
      ),
      errorParser: (data) => throw ApiErrorResponse.fromJson(data),
    );
  }

  Future<bool> deleteRecipe({required String recipeId}) async {
    final uri = api.recipe(recipeId);
    return await _client.deleteData(
      uri: uri,
      parser: (data) => true,
      errorParser: (data) => throw ApiErrorResponse.fromJson(data),
    );
  }

  // * Is this needed?
  // static Recipe? _getRecipe(List<Recipe> recipes, String id) {
  //   return recipes.firstWhereOrNull((recipe) => recipe.id == id);
  // }
}

final recipesRepositoryProvider = Provider<RecipesRepository>(
  (ref) => RecipesRepository(api: RecipesAPI()),
);

// * Moved to controller
final recipesListFutureProvider2 = FutureProvider.autoDispose<List<Recipe>>(
  (ref) {
    final recipesRepository = ref.watch(recipesRepositoryProvider);

    return recipesRepository.fetchRecipesList2();
  },
);

// * Moved to controller
// final recipeFutureProvider2 =
//     FutureProvider.autoDispose.family<Recipe, String>((ref, id) {
//   final recipesRepository = ref.watch(recipesRepositoryProvider);

//   final link = ref.keepAlive();

//   Timer? timer;

//   ref.onDispose(
//     () {
//       timer?.cancel();
//       debugPrint("Disposed");
//     },
//   );

//   ref.onCancel(
//     () {
//       timer = Timer(
//         const Duration(seconds: 30),
//         () {
//           debugPrint("Closed");
//           link.close();
//         },
//       );
//       debugPrint("Cancelled, starting timer...");
//     },
//   );

//   ref.onResume(
//     () {
//       timer?.cancel();
//       debugPrint("Resumed");
//     },
//   );

//   return recipesRepository.fetchRecipe2(id);
// });

// ? Local data
// final recipesListFutureProvider =
//     FutureProvider.autoDispose<List<Recipe>>((ref) {
//   final recipesRepository = ref.watch(recipesRepositoryProvider);

//   return recipesRepository.fetchRecipesList();
// });

// final recipeProvider = Provider.autoDispose.family<Recipe, String>((ref, id) {
//   final recipesRepository = ref.watch(recipesRepositoryProvider);

//   return recipesRepository.getRecipe(id)!;
// });
