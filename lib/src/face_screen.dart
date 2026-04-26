import 'package:flutter/material.dart';
import 'package:flutter_artist_face/src/widget/internal_custom_app_container.dart';
import 'package:flutter_artist_theme/flutter_artist_theme.dart';

import '../flutter_artist_face.dart';
import 'helper/responsive_helper.dart';
import 'style/topbar_style.dart';

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

  Widget buildDrawerExpandedLogo({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  });

  Widget buildDrawerCollapsedLogo({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  });

  Widget buildDrawerExpandedProfile({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  });

  Widget buildDrawerCollapsedProfile({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  });

  Widget buildBody(BuildContext context, {required FaceStyle effectiveStyle});

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

  FaceStyle buildSidebarStyle(BuildContext context) => const FaceStyle();

  /// Users can override this screen to define their own style.
  FaceStyle buildStyle(BuildContext context);

  /// Get styles from the Theme (usually via Theme.of(context).extension<...>)
  /// User can override this method.
  @override
  FaceStyle? themeStyle(BuildContext context) {
    final theme = Theme.of(context);
    FaTheme faTheme = FaThemeHub.instance.getCurrentTheme();

    return FaceStyle(
      scaffoldBackground: theme.scaffoldBackgroundColor,
      sidebarStyle: SidebarStyle(
        backgroundColor: faTheme.tokens.layout.colors.sidebarSurface,
        itemIconColor: faTheme.tokens.layout.colors.onSidebarSurface,
        itemTextColor: faTheme.tokens.layout.colors.onSidebarSurface,
        itemBorderRadius: faTheme.tokens.shortcut.borderRadius,
        //
        groupTitleStyle: TextStyle(
          color: faTheme.tokens.colors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        groupSubtitleStyle: TextStyle(
          color: faTheme.tokens.layout.colors.onSidebarSurface.withValues(
            alpha: 0.5,
          ),
          fontSize: 11,
        ),
        itemHoverColor: faTheme.tokens.layout.colors.onSidebarSurface
            .withValues(alpha: 0.1),
        itemSelectedColor: faTheme.tokens.layout.colors.onSidebarSurface
            .withValues(alpha: 0.2),
      ),
      topbarStyle: TopbarStyle(
        backgroundColor: faTheme.tokens.layout.colors.topbarSurface,
        iconColor: faTheme.tokens.layout.colors.onTopbarSurface,
        textColor: faTheme.tokens.layout.colors.onTopbarSurface,
      ),
    );
  }

  /// 3-Layer Unified Logic Processing Method.
  FaceStyle _resolveStyle(BuildContext context) {
    final userStyle = buildStyle(context);
    final appThemeStyle = themeStyle(context);
    final systemDefaults = FaceStyle.defaults();

    // Priority order: User > Theme > Defaults
    return userStyle.merge(appThemeStyle).merge(systemDefaults);
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
  bool _isMenuDrawerExpanded = true;

  void _handleToggleMenuDrawer() {
    setState(() {
      _isMenuDrawerExpanded = !_isMenuDrawerExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveHelper.isMobile(context);
    final FaceStyle effectiveStyle = widget._resolveStyle(context);

    // Prepare Native EndDrawer
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
      drawer: isMobile
          ? _buildMenuDrawer(
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
            _buildMenuDrawer(
              context,
              effectiveStyle: effectiveStyle,
              isMobile: false,
              isExpanded: _isMenuDrawerExpanded,
            ),
          Expanded(
            child: Column(
              children: [
                TopMenuBar(
                  effectiveStyle: effectiveStyle,
                  isMobile: isMobile,
                  isMenuDrawerExpanded: _isMenuDrawerExpanded,
                  onToggleMenuDrawer: _handleToggleMenuDrawer,
                  buildTopMenuLeading: widget.buildTopMenuLeading,
                  buildTopMenuCenter: widget.buildTopMenuCenter,
                  buildTopMenuTrailing: widget.buildTopMenuTrailing,
                ),
                Expanded(
                  child: widget.buildBody(
                    context,
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

  /// Internal helper to build the drawer with navigation logic
  Widget _buildMenuDrawer(
    BuildContext context, {
    required FaceStyle effectiveStyle,
    required bool isMobile,
    required bool isExpanded,
  }) {
    return MenuDrawer(
      isMobile: isMobile,
      isExpanded: isExpanded,
      onToggle: isMobile
          ? () => Navigator.of(context).pop()
          : _handleToggleMenuDrawer,
      effectiveStyle: effectiveStyle,
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
