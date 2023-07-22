import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_recipes/src/features/authentication/data/auth_repository.dart';
import 'package:my_recipes/src/features/authentication/presentation/email_password_sign_in_screen.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/create_recipe_screen.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/edit_recipe_screen.dart';
import 'package:my_recipes/src/features/recipes/presentation/recipe_screen/add_to_shopping_list_screen.dart';
import 'package:my_recipes/src/features/recipes/presentation/recipe_screen/recipe_screen.dart';
import 'package:my_recipes/src/routing/go_router_refresh_stream.dart';
import 'package:my_recipes/src/routing/scaffold_with_bottom_nav_bar.dart';
import 'package:my_recipes/src/routing/scaffold_with_nav_bar_tab_item.dart';
import 'package:my_recipes/src/features/recipes/presentation/recipes_list/recipes_list_screen.dart';
import 'package:my_recipes/src/features/search/presentation/search_screen.dart';
import 'package:my_recipes/src/features/shopping_list/presentation/shopping_list/shopping_list_screen.dart';
import 'package:my_recipes/src/routing/splash_screen.dart';

enum AppRoute {
  recipes,
  recipe,
  editRecipe,
  createRecipe,
  addRecipeToCart,
  search,
  shoppingList,
  signIn,
  splashScreen,
}

const signInNamedPage = "/sign-in";
const homeNamedPage = "/recipes";
const createRecipeNamedPage = "create";
const recipeNamedPage = ":id";
const recipeAddToCartNamedPage = "add-to-cart";
const editRecipeNamedPage = "edit";
const searchNamedPage = "/search";
const shoppingListNamedPage = "/shopping-list";
const splashScreenNamedPage = "/splash-screen";

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

const tabs = [
  ScaffoldWithNavBarTabItem(
    initialLocation: homeNamedPage,
    icon: Icon(Icons.home),
    label: 'Recipes',
  ),
  ScaffoldWithNavBarTabItem(
    initialLocation: searchNamedPage,
    icon: Icon(Icons.search),
    label: 'Search',
  ),
  ScaffoldWithNavBarTabItem(
    initialLocation: shoppingListNamedPage,
    icon: Icon(Icons.list),
    label: 'Shopping list',
  ),
];

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    final isPersistedUser = ref.watch(fetchPersistedUserProvider);
    debugPrint("State: $isPersistedUser");

    return GoRouter(
      initialLocation: isPersistedUser.when(
        data: (persistedUser) =>
            persistedUser ? homeNamedPage : signInNamedPage,
        loading: () => splashScreenNamedPage,
        error: (error, stackTrace) {
          debugPrint("Error: $error");
          return signInNamedPage;
        },
      ),
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      redirect: (context, state) {
        final isLoggedIn = authRepository.currentUser != null;

        debugPrint("isLoggedIn: $isLoggedIn");

        if (!isLoggedIn && !isPersistedUser.isLoading) {
          return signInNamedPage;
        }

        return null;
      },
      refreshListenable: GoRouterRefreshStream(
        authRepository.authStateChanges,
      ),
      routes: [
        GoRoute(
          path: splashScreenNamedPage,
          name: AppRoute.splashScreen.name,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const SplashScreen(),
          ),
        ),
        GoRoute(
          path: signInNamedPage,
          name: AppRoute.signIn.name,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const EmailPasswordSignInScreen(),
          ),
        ),
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return ScaffoldWithBottomNavBar(
              tabs: tabs,
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: homeNamedPage,
              name: AppRoute.recipes.name,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const RecipesListScreen(),
              ),
              routes: [
                GoRoute(
                  path: createRecipeNamedPage,
                  name: AppRoute.createRecipe.name,
                  pageBuilder: (context, state) => NoTransitionPage(
                    key: state.pageKey,
                    child: CreateRecipeScreen(),
                    // child: const CreateEditRecipeScreen(),
                  ),
                ),
                GoRoute(
                  path: recipeNamedPage,
                  name: AppRoute.recipe.name,
                  pageBuilder: (context, state) {
                    final recipeId = state.params["id"]!;

                    return CustomTransitionPage(
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      },
                      key: state.pageKey,
                      child: RecipeScreen(
                        recipeId: recipeId,
                      ),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: editRecipeNamedPage,
                      name: AppRoute.editRecipe.name,
                      pageBuilder: (context, state) {
                        final recipeId = state.params["id"]!;

                        return MaterialPage(
                          child: EditRecipeScreen(
                            recipeId: recipeId,
                          ),
                        );
                        return CustomTransitionPage(
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(1, 0),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            );
                          },
                          key: state.pageKey,
                          child: EditRecipeScreen(
                            recipeId: recipeId,
                          ),
                        );
                      },
                    ),
                    GoRoute(
                      path: recipeAddToCartNamedPage,
                      name: AppRoute.addRecipeToCart.name,
                      pageBuilder: (context, state) {
                        final recipeId = state.params["id"]!;

                        return MaterialPage(
                            child: AddToShoppingListScreen(
                          recipeId: recipeId,
                        ));
                      },
                    )
                  ],
                ),
              ],
            ),
            GoRoute(
              path: searchNamedPage,
              name: AppRoute.search.name,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const SearchScreen(),
              ),
            ),
            GoRoute(
              path: shoppingListNamedPage,
              name: AppRoute.shoppingList.name,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const ShoppingListScreen(),
              ),
            ),
          ],
        ),
      ],
    );
  },
);
