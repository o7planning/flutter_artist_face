part of '../menu_model.dart';

/// An enterprise-grade, immutable data token class mapping operational properties,
/// routing targets, graphics, and interaction behaviors for an individual sidebar menu item.
///
/// Integrated into the `FlutterArtist` core lifecycle, it encapsulates independent action triggers,
/// holding specific state evaluation flags and peripheral route patterns to handle reactive selection tracking.
class SidebarMenuItemModel {
  /// The unique programmatic machine-readable key token utilized to track this model across runtime lifecycles.
  final String code;

  /// The human-readable plaintext string displayed as the main title description for the menu row.
  final String? menuTitle;

  /// The targeted internal system named route path indicator used to trigger implicit navigation shifts.
  final String? route;

  /// The material vector symbol icon graphic asset rendered inside the leading boundary of the item row.
  final IconData iconData;

  /// Holds numeric value metrics to feed interactive alert badge counters or telemetric status flags.
  final int? notifyValue;

  /// The absolute external web link path resource directed to fire outbound web browser engines.
  final String? externalUrl;

  /// Determines if this item is currently active in the UI.
  ///
  /// The selection logic should be handled by the parent based on the current URI/Route.
  final bool isSelected;

  /// An optional collection list of alternative route path indicators that should also force
  /// this specific menu node to flag its selection state active.
  final List<String>? markAsSelectedForRoutes;

  /// Constructs a declarative, production-grade instance of [SidebarMenuItemModel] with default state baselines.
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
  ///
  /// Parses the embedded [externalUrl] string safely and dispatches it out toward
  /// the runtime host operating system to mount inside an external application window.
  Future<void> openExternalUrl() async {
    if (externalUrl != null) {
      final url = Uri.parse(externalUrl!);
      // Assuming typical url_launcher package stub structures are mapped in project dependencies
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    }
  }
}
