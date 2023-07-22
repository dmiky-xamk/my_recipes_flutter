// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_recipes/src/features/recipes/domain/ingredient.dart';
import 'package:my_recipes/src/features/recipes/domain/recipe.dart';
import 'package:my_recipes/src/features/recipes/presentation/recipe_screen/recipe_controller.dart';
import 'package:my_recipes/src/features/shopping_list/application/shopping_list_service.dart';
import 'package:my_recipes/src/features/shopping_list/domain/shopping_list.dart';
import 'package:my_recipes/src/features/shopping_list/domain/shopping_list_ingredient.dart';

class SelectableIngredient {
  SelectableIngredient({
    required this.isSelected,
    required this.name,
  });

  final bool isSelected;
  final String name;

  @override
  bool operator ==(covariant SelectableIngredient other) {
    if (identical(this, other)) return true;

    return other.isSelected == isSelected && other.name == name;
  }

  @override
  int get hashCode => isSelected.hashCode ^ name.hashCode;

  SelectableIngredient copyWith({
    bool? isSelected,
    String? name,
  }) {
    return SelectableIngredient(
      isSelected: isSelected ?? this.isSelected,
      name: name ?? this.name,
    );
  }
}

class AddToShoppingListController
    extends StateNotifier<List<SelectableIngredient>> {
  AddToShoppingListController(
    this.shoppingListService,
    this.ref,
  ) : super([]);
  final ShoppingListService shoppingListService;
  final Ref ref;

  // void addIngredient(String ingredientName, String recipeId) {
  //   state = AsyncValue.guard(
  //     () => shoppingListService.addIngredient(ingredientName, recipeId),
  //   );
  // }

  void _initialize(String recipeId) async {
    final recipe = ref.read(recipeControllerProvider(recipeId));
    final List<Ingredient> ingredients = recipe.asData!.value.ingredients;
    final shoppingListIngredients =
        await checkIfIngredientsInShoppingList(recipeId);

    state = ingredients
        .map(
          (ingredient) => SelectableIngredient(
            isSelected: shoppingListIngredients
                .any((element) => element.ingredientName == ingredient.name),
            name: ingredient.name,
          ),
        )
        .toList();
    // state = ingredients.whenData((value) => value.map(
    //   (ingredient) => SelectableIngredient(
    //     isSelected: false,
    //     name: ingredient.name,
    //   ),
    // ));
    // .toList();
  }

  Future<Iterable<ShoppingListIngredient>> checkIfIngredientsInShoppingList(
      String recipeId) async {
    final list = await ref
        .read(shoppingListServiceProvider)
        .shoppingListRepository
        .fetchShoppingList();

    return list.ingredients.where((element) => element.recipeId == recipeId);
  }

  void toggle(int index) {
    state = [
      ...state,
      state[index].copyWith(isSelected: !state[index].isSelected),
    ];
  }
}

// final addToListProvider = AutoDisposeStateNotifierProviderFamily((ref, String arg) {
//   final recipe = ref.watch(recipeControllerProvider(arg));

//   return AddToShoppingListController(recipe);
// },);

final testProvider = StateNotifierProvider(
  (ref) {
    final shoppingListService = ref.watch(shoppingListServiceProvider);

    return AddToShoppingListController(shoppingListService, ref);
  },
);

final testProvider2 = StateNotifierProvider.family<AddToShoppingListController,
    List<SelectableIngredient>, String>(
  (ref, String recipeId) {
    final shoppingListService = ref.watch(shoppingListServiceProvider);

    return AddToShoppingListController(shoppingListService, ref);
  },
);

// **************************************************************************

class RecipeShoppingListIngredientsState {
  RecipeShoppingListIngredientsState({
    required this.recipe,
    required this.shoppingList,
  });

  final AsyncValue<Recipe> recipe;
  final AsyncValue<ShoppingList> shoppingList;

  RecipeShoppingListIngredientsState copyWith({
    AsyncValue<Recipe>? recipe,
    AsyncValue<ShoppingList>? shoppingList,
  }) {
    return RecipeShoppingListIngredientsState(
      recipe: recipe ?? this.recipe,
      shoppingList: shoppingList ?? this.shoppingList,
    );
  }

  @override
  String toString() =>
      'RecipeShoppingListIngredientsState(recipe: $recipe, shoppingList: $shoppingList)';

  @override
  bool operator ==(covariant RecipeShoppingListIngredientsState other) {
    if (identical(this, other)) return true;

    return other.recipe == recipe && other.shoppingList == shoppingList;
  }

  @override
  int get hashCode => recipe.hashCode ^ shoppingList.hashCode;
}

// **************************************************************************

class RecipeAddableIngredient {
  RecipeAddableIngredient({
    required this.recipeId,
    required this.name,
    required this.isAdded,
  });

  final String recipeId;
  final String name;
  final bool isAdded;

  RecipeAddableIngredient copyWith({
    String? recipeId,
    String? name,
    bool? isAdded,
  }) {
    return RecipeAddableIngredient(
      recipeId: recipeId ?? this.recipeId,
      name: name ?? this.name,
      isAdded: isAdded ?? this.isAdded,
    );
  }
}

class AddableIngredientNotifier
    extends StateNotifier<AsyncValue<List<RecipeAddableIngredient>>> {
  AddableIngredientNotifier(
    this.ref,
    this.shoppingListService,
    String id,
    AsyncValue<Recipe> recipe,
  ) : super(const AsyncLoading()) {
    _initialize(recipe);
  }

  final Ref ref;
  ShoppingListService shoppingListService;
  late final ShoppingList _shoppingList;

  void _initialize(AsyncValue<Recipe> recipe) async {
    final rec = recipe.valueOrNull!;

    final shoppingList = await AsyncValue.guard(
      () => shoppingListService.fetchRecipeShoppingList(rec.id),
    );

    _shoppingList = shoppingList.valueOrNull!;

    final addableIngredients = rec.ingredients
        .map((ing) => RecipeAddableIngredient(
              recipeId: rec.id,
              name: ing.name,
              isAdded: shoppingList.valueOrNull!.ingredients
                  .any((element) => element.ingredientName == ing.name),
            ))
        .toList();

    state = AsyncData(addableIngredients);
  }

  bool isAdded(String name) {
    return state.valueOrNull!.any((element) => _shoppingList.ingredients
        .any((element) => element.ingredientName == name));
  }
}

final addableIngredientProvider = StateNotifierProvider.autoDispose.family<
    AddableIngredientNotifier,
    AsyncValue<List<RecipeAddableIngredient>>,
    String>(
  (ref, String id) {
    final shoppingListService = ref.watch(shoppingListServiceProvider);
    final recipe = ref.watch(recipeControllerProvider(id));

    return AddableIngredientNotifier(
      ref,
      shoppingListService,
      id,
      recipe,
    );
  },
);

// ===========================================================================
// ===========================================================================

/// Logic for adding and removing ingredients from the shopping list
/// Listen to this to catch possible errors
class RecipeShoppingListIngredientsController
    extends StateNotifier<AsyncValue<void>> {
  RecipeShoppingListIngredientsController({required this.shoppingListService})
      : super(const AsyncData(null));

  final ShoppingListService shoppingListService;

  Future<void> addIngredient({
    required String ingredientName,
    required String recipeId,
    required String recipeName,
  }) async {
    state = await AsyncValue.guard(
      () => shoppingListService.addIngredient(
          ingredientName, recipeId, recipeName),
    );
  }

  Future<void> deleteIngredient({
    required String ingredientName,
    required String recipeId,
  }) async {
    state = const AsyncLoading<void>();

    state = await AsyncValue.guard(() =>
        shoppingListService.deleteRecipeIngredient(ingredientName, recipeId));
  }

  // Future<void> toggle(bool? isAdded, String name, String recipeId) async {
  //   debugPrint('toggle: $isAdded, $name, $recipeId');
  //   if (isAdded == true) {
  //     return await deleteIngredient(name, recipeId);
  //   } else {
  //     return await addIngredient(name, recipeId);
  //   }
  // }

  // Future<void> toggleIngredient(int id) async {
  //   state = const AsyncLoading<void>();

  //   state =
  //       await AsyncValue.guard(() => shoppingListService.toggleIngredient(id));
  // }
}

final recipeShoppingListControllerProvider = StateNotifierProvider<
    RecipeShoppingListIngredientsController, AsyncValue<void>>(
  (ref) {
    final shoppingListService = ref.watch(shoppingListServiceProvider);

    return RecipeShoppingListIngredientsController(
      shoppingListService: shoppingListService,
    );
  },
);

// ===========================================================================

class RecipeShoppingList {
  RecipeShoppingList(
    this.recipe,
    this.recipeShoppingList,
  );

  final AsyncValue<Recipe> recipe;
  final AsyncValue<ShoppingList> recipeShoppingList;
}

// The checkboxes act after a delay
/*
  FIX:
  - I need the recipe for the ingredients and the recipeShoppingList to check if the ingredient is added
  - 
*/
class RecipeShoppingListState extends StateNotifier<RecipeShoppingList> {
  RecipeShoppingListState(
    AsyncValue<Recipe> recipe,
    AsyncValue<ShoppingList> recipeShoppingList,
  ) : super(
          RecipeShoppingList(
            recipe,
            recipeShoppingList,
          ),
        );
  // final AsyncValue<Recipe> recipe;
  // final AsyncValue<ShoppingList> recipeShoppingList;

  bool isAdded(String name) {
    return state.recipeShoppingList.whenData(
          (value) {
            return value.ingredients
                .any((element) => element.ingredientName == name);
          },
        ).value ??
        false;
  }
}

final testProvider3 = StateNotifierProvider.autoDispose
    .family<RecipeShoppingListState, RecipeShoppingList, String>(
  (ref, recipeId) {
    // final shoppingListService = ref.watch(shoppingListServiceProvider);
    final recipe =
        ref.watch(recipeControllerProvider(recipeId)); // TODO: Test wrong id
    final recipeShoppingList = ref.watch(shoppingRecipeWatchProvider(recipeId));

    return RecipeShoppingListState(recipe, recipeShoppingList);
  },
);
