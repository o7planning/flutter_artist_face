part of '../menu_model.dart';

/// An enterprise-grade data layout model representing an organized category section
/// inside the global sidebar navigation ecosystem.
///
/// Designed within the `FlutterArtist` framework, [SidebarMenuGroupModel] groups independent
/// menu tracks together under a unified header block configured with optional text labels.
class SidebarMenuGroupModel {
  /// The primary plaintext title label drawn as the section category header text.
  final String title;

  /// The secondary plaintext description subtitle string providing contextual overview details.
  final String subtitle;

  /// Dictates whether the group category header boundary mounts visible dividers and typography onto the canvas.
  final bool showHeader;

  /// The underlying collection array holding all sub-level active menu item models assigned to this group.
  final List<SidebarMenuItemModel> menus;

  /// Constructs a production-ready, immutable declarative instance of [SidebarMenuGroupModel].
  const SidebarMenuGroupModel({
    required this.title,
    required this.subtitle,
    required this.menus,
    this.showHeader = true,
  });
}
