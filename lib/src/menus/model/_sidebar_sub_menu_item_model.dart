part of '../menu_model.dart';

class SidebarSubMenuItemModel {
  final String subMenuCode;
  final String? subMenuTitle;
  final String? route;

  const SidebarSubMenuItemModel({
    required this.subMenuCode,
    required this.subMenuTitle,
    required this.route,
  });
}
