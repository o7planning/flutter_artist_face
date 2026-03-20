import 'package:flutter/material.dart';

/// Defines the visual configuration for the MenuDrawer and its items.
/// Following the FlutterArtist philosophy of flexible yet structured UI.
class MenuDrawerStyle {
  /// The background color of the entire drawer side bar.
  final Color backgroundColor;

  /// Width of the drawer when it is fully expanded.
  final double expandedWidth;

  /// Width of the drawer when it is collapsed (icon-only mode).
  final double collapsedWidth;

  /// Styling for the Menu Groups (Headers).
  final EdgeInsets groupPadding;
  final TextStyle groupTitleStyle;
  final TextStyle groupSubtitleStyle;

  /// Styling for individual Menu Items.
  final EdgeInsets itemPadding;
  final double itemBorderRadius;
  final Color itemIconColor;
  final Color itemTextColor;

  /// Interactive colors for the Menu Items.
  final Color? itemHoverColor;
  final Color? itemSelectedColor;

  const MenuDrawerStyle({
    this.backgroundColor = const Color.fromARGB(255, 15, 23, 42),
    this.expandedWidth = 240,
    this.collapsedWidth = 60,
    this.groupPadding = const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
    this.groupTitleStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 13,
      color: Colors.lightBlue,
    ),
    this.groupSubtitleStyle = const TextStyle(color: Colors.grey, fontSize: 11),
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    this.itemBorderRadius = 6.0,
    this.itemIconColor = Colors.white,
    this.itemTextColor = Colors.white,
    this.itemHoverColor,
    this.itemSelectedColor,
  });
}
