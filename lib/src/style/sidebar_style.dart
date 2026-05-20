import 'package:flutter/material.dart';

/// Defines the visual configuration for the Sidebar and its items.
/// Following the FlutterArtist philosophy of flexible yet structured UI.
class SidebarStyle {
  final Color backgroundColor;
  final double expandedWidth;
  final double collapsedWidth;
  final EdgeInsets groupPadding;
  final TextStyle groupTitleStyle;
  final TextStyle groupSubtitleStyle;
  final EdgeInsets itemPadding;
  final double itemBorderRadius;
  final Color itemIconColor;
  final Color itemTextColor;
  final Color itemHoverColor;
  final Color itemSelectedColor;

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
