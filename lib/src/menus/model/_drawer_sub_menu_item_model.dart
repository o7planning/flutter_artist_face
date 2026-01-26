part of '../menu_model.dart';

class DrawerSubMenuItemModel {
  final String subMenuCode;
  final String? subMenuTitle;
  final String? route;

  const DrawerSubMenuItemModel({
    required this.subMenuCode,
    required this.subMenuTitle,
    required this.route,
  });
}
