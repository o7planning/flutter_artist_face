part of '../menu_model.dart';

class DrawerMenuGroupModel {
  final String title;
  final String subtitle;
  final bool showHeader;

  final List<DrawerMenuItemModel> menus;

  const DrawerMenuGroupModel({
    required this.title,
    required this.subtitle,
    required this.menus,
    this.showHeader = true,
  });
}
