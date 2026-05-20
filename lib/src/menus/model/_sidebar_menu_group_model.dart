part of '../menu_model.dart';

class SidebarMenuGroupModel {
  final String title;
  final String subtitle;
  final bool showHeader;

  final List<SidebarMenuItemModel> menus;

  const SidebarMenuGroupModel({
    required this.title,
    required this.subtitle,
    required this.menus,
    this.showHeader = true,
  });
}
