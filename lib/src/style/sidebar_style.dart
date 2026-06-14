import 'package:flutter/material.dart';

/// An enterprise-grade, immutable configuration model containing comprehensive painting
/// metrics and decorative appearance rules for sidebar menu layouts.
///
/// Designed within the `FlutterArtist` framework ecosystem, [SidebarStyle] consolidates all
/// structural width dimensions, text formatting rules, and dynamic layer state interaction colors.
/// It allows developers to customize side-navigation components cleanly without injecting hardcoded values.
class SidebarStyle {
  /// The foundational color profile applied to color the main sidebar container canvas background.
  final Color backgroundColor;

  /// The horizontal width dimension metric allocated to the sidebar panel when expanded in full desktop mode.
  final double expandedWidth;

  /// The narrow horizontal width dimension metric reserved for the sidebar layout when collapsed into icon-only rows.
  final double collapsedWidth;

  /// The layout cushioning spacing wrapped around structural menu grouping title bars.
  final EdgeInsets groupPadding;

  /// The typographic look and formatting style properties applied to paint main grouping title strings.
  final TextStyle groupTitleStyle;

  /// The typographic look and formatting style properties applied to paint secondary subgroup description labels.
  final TextStyle groupSubtitleStyle;

  /// The internal cellular padding spacing cleared within the edges of individual navigation rows.
  final EdgeInsets itemPadding;

  /// The circular curvature metric properties rounding off the corners of interactive menu item container boxes.
  final double itemBorderRadius;

  /// The thematic color asset applied to paint vector icon graphics inside inactive navigation rows.
  final Color itemIconColor;

  /// The thematic color asset applied to format plaintext runs inside inactive navigation menu labels.
  final Color itemTextColor;

  /// The background highlight tint applied across an item container lane during interactive hover tracking states.
  final Color itemHoverColor;

  /// The persistent background highlight fill coloring applied over the active selected navigation menu row segment.
  final Color itemSelectedColor;

  /// Initializes a production-ready, immutable declarative instance of [SidebarStyle] with explicit style metrics.
  const SidebarStyle({
    required this.backgroundColor,
    required this.expandedWidth,
    required this.collapsedWidth,
    required this.groupPadding,
    required this.groupTitleStyle,
    required this.groupSubtitleStyle,
    required this.itemPadding,
    required this.itemBorderRadius,
    required this.itemIconColor,
    required this.itemTextColor,
    required this.itemHoverColor,
    required this.itemSelectedColor,
  });

  /// Combines this sidebar style template configuration seamlessly with a secondary input modifier style token loop.
  ///
  /// Attributes defined within the [other] argument override this instance's baseline settings completely.
  ///
  /// * [other]: The secondary configuration instance injected to overwrite layout properties.
  SidebarStyle merge(SidebarStyle? other) {
    if (other == null) return this;
    return SidebarStyle(
      backgroundColor: other.backgroundColor,
      expandedWidth: other.expandedWidth,
      collapsedWidth: other.collapsedWidth,
      groupPadding: other.groupPadding,
      groupTitleStyle: other.groupTitleStyle,
      groupSubtitleStyle: other.groupSubtitleStyle,
      itemPadding: other.itemPadding,
      itemBorderRadius: other.itemBorderRadius,
      itemIconColor: other.itemIconColor,
      itemTextColor: other.itemTextColor,
      itemHoverColor: other.itemHoverColor,
      itemSelectedColor: other.itemSelectedColor,
    );
  }
}
