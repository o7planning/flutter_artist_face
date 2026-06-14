part of '../face_screen.dart';

/// An enterprise-grade navigation sidebar container widget that acts as the primary
/// vertical control panel for standard layout management frameworks.
///
/// Designed as a core presentation component within the `FlutterArtist` ecosystem,
/// [SidebarMenu] orchestrates dynamic lists of menu groups, administrative profile badges,
/// corporate branding logos, and localized configuration panels seamlessly across adaptive layout bounds.
class SidebarMenu extends StatelessWidget {
  /// The structural dataset collection containing categorized groupings utilized
  /// to populate the primary body lane of the vertical menu column.
  final List<SidebarMenuGroupModel> sidebarMenuGroupModels;

  /// Optional contextual application metadata used to configure and build the dedicated
  /// system setup cell option row near the lower terminal anchor of the panel.
  final SidebarMenuItemModel? configurationMenuItemModel;

  /// A structural runtime builder intercepting the viewport tree to compile and render
  /// comprehensive account information blocks when the panel is in its full expanded width state.
  final Widget Function({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  })
  buildSidebarExpandedProfile;

  /// A structural runtime builder intercepting the viewport tree to compile and render
  /// space-saving account graphics or circular badges when the panel is in its collapsed width state.
  final Widget Function({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  })
  buildSidebarCollapsedProfile;

  /// A modular branding blueprint factory building corporate visual logos or framework names
  /// at the absolute upper crest zone of the column frame during full width panel states.
  final Widget Function({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  })
  buildSidebarExpandedLogo;

  /// A modular branding blueprint factory building micro visual symbols or system icons
  /// at the absolute upper crest zone of the column frame during minimized width panel states.
  final Widget Function({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  })
  buildSidebarCollapsedLogo;

  /// Dictates if the navigation menu container fills out its maximum extended layout width
  /// or contracts into a minimized icon-only command strip.
  final bool isExpanded;

  /// Flags if the hosting device conforms to a compact viewport constraints matrix,
  /// dynamically adjusting responsive behavioral interaction layers.
  final bool isMobile;

  /// The active composite look-and-feel configuration token defining color schemas,
  /// geometrical boundary dimensions, text formats, and padding spaces down the widget graph.
  final FaceStyle effectiveStyle;

  /// Fires a custom programmatic execution handler callback upstream immediately upon
  /// intercepting interactive touch gestures on the top header toggle sector.
  final VoidCallback onToggle;

  /// Intercepts valid child option cell selection gestures to delegate targeted
  /// named route switching operations back up to host orchestration modules.
  final Function(SidebarMenuItemModel menuModel) onMenuItemTap;

  /// Constructs a production-ready, immutable declarative instance of [SidebarMenu]
  /// with explicit structure parameters.
  const SidebarMenu({
    super.key,
    required this.sidebarMenuGroupModels,
    required this.configurationMenuItemModel,
    required this.buildSidebarExpandedProfile,
    required this.buildSidebarCollapsedProfile,
    required this.buildSidebarExpandedLogo,
    required this.buildSidebarCollapsedLogo,
    required this.isExpanded,
    required this.isMobile,
    required this.onToggle,
    required this.onMenuItemTap,
    required this.effectiveStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isExpanded
          ? effectiveStyle.sidebarStyle.expandedWidth
          : effectiveStyle.sidebarStyle.collapsedWidth,
      decoration: BoxDecoration(
        color: effectiveStyle.sidebarStyle.backgroundColor,
        boxShadow: null,
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            _buildControlTile(context: context),
            isExpanded
                ? buildSidebarExpandedProfile(
                    context: context,
                    effectiveStyle: effectiveStyle,
                  )
                : buildSidebarCollapsedProfile(
                    context: context,
                    effectiveStyle: effectiveStyle,
                  ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: sidebarMenuGroupModels
                      .map(
                        (group) =>
                            _buildMenuGroup(context, group, effectiveStyle),
                      )
                      .toList(),
                ),
              ),
            ),
            if (configurationMenuItemModel != null)
              Padding(
                padding: isExpanded
                    ? effectiveStyle.sidebarStyle.groupPadding
                    : const EdgeInsets.all(5),
                child: MenuItem(
                  menuModel: configurationMenuItemModel!,
                  isExpanded: isExpanded,
                  isMobile: isMobile,
                  style: effectiveStyle,
                  onTap: () => onMenuItemTap(configurationMenuItemModel!),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuGroup(
    BuildContext context,
    SidebarMenuGroupModel menuGroup,
    FaceStyle effectiveStyle,
  ) {
    // If header is completely hidden, bypass ExpansionTile layout entirely
    // to prevent internal layout padding gaps from injecting ghost spacing.
    if (!menuGroup.showHeader) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: menuGroup.menus
            .map(
              (menuModel) => Padding(
                padding: effectiveStyle.sidebarStyle.itemPadding,
                child: MenuItem(
                  menuModel: menuModel,
                  isExpanded: isExpanded,
                  isMobile: isMobile,
                  style: effectiveStyle,
                  onTap: () => onMenuItemTap(menuModel),
                ),
              ),
            )
            .toList(),
      );
    }

    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        minTileHeight: 0,
        enabled: menuGroup.showHeader,
        title: isExpanded
            ? Text(
                menuGroup.title,
                style: effectiveStyle.sidebarStyle.groupTitleStyle,
              )
            : const Divider(height: 4, color: Colors.white24),
        subtitle: isExpanded
            ? Text(
                menuGroup.subtitle,
                style: effectiveStyle.sidebarStyle.groupSubtitleStyle,
              )
            : null,
        backgroundColor: Colors.transparent,
        initiallyExpanded: true,
        showTrailingIcon: false,
        tilePadding: isExpanded
            ? effectiveStyle.sidebarStyle.groupPadding
            : EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        children: menuGroup.menus
            .map(
              (menuModel) => Padding(
                padding: effectiveStyle.sidebarStyle.itemPadding,
                child: MenuItem(
                  menuModel: menuModel,
                  isExpanded: isExpanded,
                  isMobile: isMobile,
                  style: effectiveStyle,
                  onTap: () => onMenuItemTap(menuModel),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildControlTile({required BuildContext context}) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
      minVerticalPadding: 10,
      contentPadding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
      title: Align(
        alignment: Alignment.centerLeft,
        child: isMobile || isExpanded
            ? buildSidebarExpandedLogo(
                context: context,
                effectiveStyle: effectiveStyle,
              )
            : buildSidebarCollapsedLogo(
                context: context,
                effectiveStyle: effectiveStyle,
              ),
      ),
      onTap: onToggle,
    );
  }
}
