import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_recipes/src/features/common_widgets/alert_dialogs.dart';
import 'package:my_recipes/src/routing/scaffold_with_nav_bar_tab_item.dart';

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar(
      {Key? key, required this.child, required this.tabs})
      : super(key: key);
  final Widget child;
  final List<ScaffoldWithNavBarTabItem> tabs;

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  int _locationToTabIndex(String location) {
    final index =
        widget.tabs.indexWhere((t) => location.startsWith(t.initialLocation));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }

  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);
  String get _currentLocation => GoRouter.of(context).location.split('/').last;

  bool _isFormPage() =>
      _currentLocation == "edit" || _currentLocation == "create";

  void _onItemTapped(BuildContext context, int tabIndex) {
    // Only navigate if the tab index has changed
    if (tabIndex != _currentIndex) {
      context.go(widget.tabs[tabIndex].initialLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: widget.tabs,
        onTap: (index) async {
          if (_isFormPage()) {
            final doDiscard = await showAlertDialog(
                  context: context,
                  title: "Discard Changes?",
                  content: "Are you sure you want to discard your changes?",
                  defaultActionText: "Discard",
                  cancelActionText: "Cancel",
                ) ??
                false;

            if (doDiscard && context.mounted) {
              _onItemTapped(context, index);
            }
          } else {
            _onItemTapped(context, index);
          }
        },
      ),
    );
  }
}
