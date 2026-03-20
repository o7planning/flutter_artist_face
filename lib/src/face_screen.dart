import 'package:flutter/material.dart';
import 'package:flutter_artist_face/src/widget/internal_custom_app_container.dart';

import 'helper/responsive_helper.dart';
import 'menus/menu_drawer_style.dart';
import 'menus/menu_item.dart';
import 'menus/menu_model.dart';

part 'controller/menu_drawer_controller.dart';
part 'end_drawer/_end_drawer_wrapper.dart';
part 'menus/menu_drawer.dart';
part 'menus/top_menu_bar.dart';

/// The core layout engine for FlutterArtist Face.
/// Redesigned to be framework-agnostic (No GetX/GoRouter dependencies).
abstract class FaceScreen extends StatefulWidget {
  const FaceScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return FaceScreenState();
  }

  // --- UI Builders to be implemented by child classes ---
  List<DrawerMenuGroupModel> buildDrawerMenuGroupModels(BuildContext context);

  DrawerMenuItemModel? buildConfigurationMenuItemModel(BuildContext context);

  Widget buildTopMenuLeading(BuildContext context);

  Widget buildTopMenuCenter(BuildContext context);

  Widget buildTopMenuTrailing(BuildContext context);

  Widget buildDrawerExpandedLogo(BuildContext context);

  Widget buildDrawerCollapsedLogo(BuildContext context);

  Widget buildDrawerExpandedProfile(BuildContext context);

  Widget buildDrawerCollapsedProfile(BuildContext context);

  Widget buildBody(BuildContext context);

  Widget? buildFooter(BuildContext context);

  Widget? buildEndDrawer(BuildContext context);

  // --- Configuration & Events ---
  double calculateEndDrawerWidth(BuildContext context) => 320;

  MenuDrawerStyle buildMenuDrawerStyle(BuildContext context) =>
      const MenuDrawerStyle();

  void onEndDrawerChanged(bool isOpened) {}

  ///
  /// Global Navigation Handler.
  /// Override this in your implementation to use Get.to, context.go, or Navigator.push.
  ///
  /// ```
  /// Navigator.of(context).pushNamed(route);
  /// ```
  ///
  void onNavigateTo(BuildContext context, String route);
}

class FaceScreenState extends State<FaceScreen> {
  bool _isMenuDrawerExpanded = true;

  void _handleToggleMenuDrawer() {
    setState(() {
      _isMenuDrawerExpanded = !_isMenuDrawerExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveHelper.isMobile(context);
    final style = widget.buildMenuDrawerStyle(context);

    // Prepare Native EndDrawer
    Widget? endDrawerWidget = widget.buildEndDrawer(context);
    Widget? finalEndDrawer = endDrawerWidget == null
        ? null
        : _EndDrawerWrapper(
            calculateEndDrawerWidth: widget.calculateEndDrawerWidth,
            build: widget.buildEndDrawer,
          );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      drawer: isMobile
          ? _buildMenuDrawer(context, isMobile: true, isExpanded: true)
          : null,
      endDrawer: finalEndDrawer,
      onEndDrawerChanged: widget.onEndDrawerChanged,
      body: Row(
        children: [
          if (!isMobile)
            _buildMenuDrawer(
              context,
              isMobile: false,
              isExpanded: _isMenuDrawerExpanded,
            ),
          Expanded(
            child: Column(
              children: [
                TopMenuBar(
                  isMobile: isMobile,
                  isMenuDrawerExpanded: _isMenuDrawerExpanded,
                  onToggleMenuDrawer: _handleToggleMenuDrawer,
                  buildTopMenuLeading: widget.buildTopMenuLeading,
                  buildTopMenuCenter: widget.buildTopMenuCenter,
                  buildTopMenuTrailing: widget.buildTopMenuTrailing,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(child: widget.buildBody(context)),
                      // if (widget.buildFooter(context) != null)
                      //   widget.buildFooter(context)!,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Internal helper to build the drawer with navigation logic
  Widget _buildMenuDrawer(
    BuildContext context, {
    required bool isMobile,
    required bool isExpanded,
  }) {
    return MenuDrawer(
      isMobile: isMobile,
      isExpanded: isExpanded,
      onToggle: isMobile
          ? () => Navigator.of(context).pop()
          : _handleToggleMenuDrawer,
      style: widget.buildMenuDrawerStyle(context),
      drawerMenuGroupModels: widget.buildDrawerMenuGroupModels(context),
      configurationMenuItemModel: widget.buildConfigurationMenuItemModel(
        context,
      ),
      buildDrawerExpandedLogo: widget.buildDrawerExpandedLogo,
      buildDrawerCollapsedLogo: widget.buildDrawerCollapsedLogo,
      buildDrawerExpandedProfile: widget.buildDrawerExpandedProfile,
      buildDrawerCollapsedProfile: widget.buildDrawerCollapsedProfile,
      // The core navigation callback
      onMenuItemTap: (menuModel) {
        if (menuModel.externalUrl != null) {
          menuModel.openExternalUrl();
        } else if (menuModel.route != null) {
          widget.onNavigateTo(context, menuModel.route!);
        }
      },
    );
  }
}
