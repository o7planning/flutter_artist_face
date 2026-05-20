part of '../menu_model.dart';

class SidebarMenuItemModel {
  final String code;
  final String? menuTitle;
  final String? route;

  /// Icons and visual markers
  final IconData iconData;
  final int? notifyValue;

  /// External link configuration
  final String? externalUrl;

  /// Determines if this item is currently active in the UI.
  /// The selection logic should be handled by the parent based on the current URI/Route.
  final bool isSelected;

  final List<String>? markAsSelectedForRoutes;

  const SidebarMenuItemModel({
    required this.code,
    required this.iconData,
    this.menuTitle,
    this.route,
    this.isSelected = false,
    this.notifyValue,
    this.externalUrl,
    this.markAsSelectedForRoutes,
  });

  /// Utility to handle external link launching.
  Future<void> openExternalUrl() async {
    if (externalUrl != null) {
      final url = Uri.parse(externalUrl!);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    }
  }
}
