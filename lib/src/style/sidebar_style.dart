import 'package:flutter/material.dart';

/// Defines the visual configuration for the MenuDrawer and its items.
/// Following the FlutterArtist philosophy of flexible yet structured UI.
class SidebarStyle {
  final Color? backgroundColor;
  final double? expandedWidth;
  final double? collapsedWidth;
  final EdgeInsets? groupPadding;
  final TextStyle? groupTitleStyle;
  final TextStyle? groupSubtitleStyle;
  final EdgeInsets? itemPadding;
  final double? itemBorderRadius;
  final Color? itemIconColor;
  final Color? itemTextColor;
  final Color? itemHoverColor;
  final Color? itemSelectedColor;

  const SidebarStyle({
    this.backgroundColor,
    this.expandedWidth,
    this.collapsedWidth,
    this.groupPadding,
    this.groupTitleStyle,
    this.groupSubtitleStyle,
    this.itemPadding,
    this.itemBorderRadius,
    this.itemIconColor,
    this.itemTextColor,
    this.itemHoverColor,
    this.itemSelectedColor,
  });

  // Chuyển toàn bộ giá trị cứng vào đây
  factory SidebarStyle.defaults() => const SidebarStyle(
    expandedWidth: 240,
    collapsedWidth: 60,
    groupPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
    groupTitleStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 13,
      color: Colors.lightBlue,
    ),
    groupSubtitleStyle: TextStyle(color: Colors.grey, fontSize: 11),
    itemPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    itemBorderRadius: 6.0,
  );

  SidebarStyle merge(SidebarStyle? other) {
    if (other == null) return this;
    return SidebarStyle(
      backgroundColor: backgroundColor ?? other.backgroundColor,
      expandedWidth: expandedWidth ?? other.expandedWidth,
      collapsedWidth: collapsedWidth ?? other.collapsedWidth,
      groupPadding: groupPadding ?? other.groupPadding,
      groupTitleStyle:
          groupTitleStyle?.merge(other.groupTitleStyle) ??
          other.groupTitleStyle,
      groupSubtitleStyle:
          groupSubtitleStyle?.merge(other.groupSubtitleStyle) ??
          other.groupSubtitleStyle,
      itemPadding: itemPadding ?? other.itemPadding,
      itemBorderRadius: itemBorderRadius ?? other.itemBorderRadius,
      itemIconColor: itemIconColor ?? other.itemIconColor,
      itemTextColor: itemTextColor ?? other.itemTextColor,
      itemHoverColor: itemHoverColor ?? other.itemHoverColor,
      itemSelectedColor: itemSelectedColor ?? other.itemSelectedColor,
    );
  }
}
