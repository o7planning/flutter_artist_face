import 'package:flutter/material.dart';
import 'package:flutter_artist_face/src/widget/internal_custom_app_container.dart';

import '../flutter_artist_face.dart';
import 'helper/responsive_helper.dart';

part 'end_drawer/_end_drawer_wrapper.dart';
part 'menus/sidebar_menu.dart';
part 'menus/top_menu_bar.dart';

/// The core layout engine for FlutterArtist Face.
/// Redesigned to be framework-agnostic (No GetX/GoRouter dependencies).
abstract class FaceScreen extends StatefulWidget {
  const FaceScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return FaceScreenState();
  }

  List<SidebarMenuGroupModel> buildSidebarMenuGroupModels(BuildContext context);

  SidebarMenuItemModel? buildConfigurationMenuItemModel(BuildContext context);

  Widget buildTopMenuLeading({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  });

  Widget buildTopMenuCenter({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  });

  Widget buildTopMenuTrailing({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  });

  Widget buildSidebarExpandedLogo({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  });

  Widget buildSidebarCollapsedLogo({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  });

  Widget buildSidebarExpandedProfile({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  });

  Widget buildSidebarCollapsedProfile({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  });

  Widget buildBody({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  });

  Widget? buildFloatingActionButton({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  }) {
    return null;
  }

  Widget? buildFooter({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  });

  Widget? buildEndDrawer({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  });

  // --- Configuration & Events ---
  double calculateEndDrawerWidth(BuildContext context) => 320;

  /// Users can override this screen to define their own style.
  FaceStyle buildStyle(BuildContext context);

  FaceStyle _resolveStyle(BuildContext context) {
    final userStyle = buildStyle(context);
    return userStyle;
  }

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
  bool _isSidebarExpanded = true;

  void _handleToggleSidebar() {
    setState(() {
      _isSidebarExpanded = !_isSidebarExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveHelper.isMobile(context);
    final FaceStyle effectiveStyle = widget._resolveStyle(context);

    Widget? endDrawerWidget = widget.buildEndDrawer(
      context: context,
      effectiveStyle: effectiveStyle,
    );
    Widget? finalEndDrawer = endDrawerWidget == null
        ? null
        : _EndDrawerWrapper(
            effectiveStyle: effectiveStyle,
            calculateEndDrawerWidth: widget.calculateEndDrawerWidth,
            build: widget.buildEndDrawer,
          );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: effectiveStyle.scaffoldBackground,
      floatingActionButton: widget.buildFloatingActionButton(
        context: context,
        effectiveStyle: effectiveStyle,
      ),
      drawer: isMobile
          ? _buildSidebar(
              context,
              effectiveStyle: effectiveStyle,
              isMobile: true,
              isExpanded: true,
            )
          : null,
      endDrawer: finalEndDrawer,
      onEndDrawerChanged: widget.onEndDrawerChanged,
      body: Row(
        children: [
          if (!isMobile)
            _buildSidebar(
              context,
              effectiveStyle: effectiveStyle,
              isMobile: false,
              isExpanded: _isSidebarExpanded,
            ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopMenuBar(
                  effectiveStyle: effectiveStyle,
                  isMobile: isMobile,
                  isSidebarExpanded: _isSidebarExpanded,
                  onToggleSidebar: _handleToggleSidebar,
                  buildTopMenuLeading: widget.buildTopMenuLeading,
                  buildTopMenuCenter: widget.buildTopMenuCenter,
                  buildTopMenuTrailing: widget.buildTopMenuTrailing,
                ),
                Expanded(
                  child: widget.buildBody(
                    context: context,
                    effectiveStyle: effectiveStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(
    BuildContext context, {
    required FaceStyle effectiveStyle,
    required bool isMobile,
    required bool isExpanded,
  }) {
    return SidebarMenu(
      isMobile: isMobile,
      isExpanded: isExpanded,
      onToggle: isMobile
          ? () => Navigator.of(context).pop()
          : _handleToggleSidebar,
      effectiveStyle: effectiveStyle,
      sidebarMenuGroupModels: widget.buildSidebarMenuGroupModels(context),
      configurationMenuItemModel: widget.buildConfigurationMenuItemModel(
        context,
      ),
      buildSidebarExpandedLogo: widget.buildSidebarExpandedLogo,
      buildSidebarCollapsedLogo: widget.buildSidebarCollapsedLogo,
      buildSidebarExpandedProfile: widget.buildSidebarExpandedProfile,
      buildSidebarCollapsedProfile: widget.buildSidebarCollapsedProfile,
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
