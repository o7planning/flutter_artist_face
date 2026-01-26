part of '../menu_model.dart';

class DrawerMenuItemModel {
  final String code;
  final String? menuTitle;
  final String? route;
  final List<String>? markAsSelectedForRoutes;
  final String? externalUrl;
  final int? notifyValue;
  final List<DrawerSubMenuItemModel> subMenuItems;
  final IconData iconData;

  const DrawerMenuItemModel({
    required this.code,
    required this.iconData,
    required this.notifyValue,
    this.menuTitle,
    this.route,
    required this.markAsSelectedForRoutes,
    this.externalUrl,
    this.subMenuItems = const [],
  });

  // https://stackoverflow.com/questions/46483949/how-to-get-current-route-path-in-flutter
  bool get isSelected {
    String currentRoute = Get.currentRoute;
    return (route == currentRoute) ||
        (markAsSelectedForRoutes != null &&
            markAsSelectedForRoutes!.contains(currentRoute));
  }
}
