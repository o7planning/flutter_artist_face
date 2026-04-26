part of '../face_screen.dart';

class MenuDrawer extends StatelessWidget {
  final List<DrawerMenuGroupModel> drawerMenuGroupModels;
  final DrawerMenuItemModel? configurationMenuItemModel;
  final Widget Function({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  })
  buildDrawerExpandedProfile;

  final Widget Function({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  })
  buildDrawerCollapsedProfile;
  final Widget Function({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  })
  buildDrawerExpandedLogo;
  final Widget Function({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  })
  buildDrawerCollapsedLogo;

  final bool isExpanded;
  final bool isMobile;
  final FaceStyle effectiveStyle;
  final VoidCallback onToggle;

  /// Callback triggered whenever a menu item is tapped
  final Function(DrawerMenuItemModel menuModel) onMenuItemTap;

  const MenuDrawer({
    super.key,
    required this.drawerMenuGroupModels,
    required this.configurationMenuItemModel,
    required this.buildDrawerExpandedProfile,
    required this.buildDrawerCollapsedProfile,
    required this.buildDrawerExpandedLogo,
    required this.buildDrawerCollapsedLogo,
    required this.isExpanded,
    required this.isMobile,
    required this.onToggle,
    required this.onMenuItemTap,
    required this.effectiveStyle,
  });

  @override
  Widget build(BuildContext context) {
    final FaThemeTokens tokens = context.faTokens;
    final effectiveDrawerBgColor = tokens.layout.colors.sidebarSurface;
    //
    return Container(
      width: isExpanded
          ? effectiveStyle.sidebarStyle?.expandedWidth
          : effectiveStyle.sidebarStyle?.collapsedWidth,
      decoration: BoxDecoration(
        color: tokens.layout.colors.sidebarSurface,
        // boxShadow: tokens.hasSidebarShadow ? tokens.sidebarShadows : null,
        boxShadow: null,
      ),
      child: Column(
        children: [
          _buildControlTile(context: context),
          isExpanded
              ? buildDrawerExpandedProfile(
                  context: context,
                  effectiveStyle: effectiveStyle,
                )
              : buildDrawerCollapsedProfile(
                  context: context,
                  effectiveStyle: effectiveStyle,
                ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: drawerMenuGroupModels
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
                  ? (effectiveStyle.sidebarStyle?.groupPadding ??
                        const EdgeInsets.all(5))
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
    );
  }

  Widget _buildMenuGroup(
    BuildContext context,
    DrawerMenuGroupModel menuGroup,
    FaceStyle effectiveStyle,
  ) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        minTileHeight: 0,
        enabled: menuGroup.showHeader,
        title: menuGroup.showHeader && isExpanded
            ? Text(
                menuGroup.title,
                style: effectiveStyle.sidebarStyle?.groupTitleStyle,
              )
            : menuGroup.showHeader
            ? const Divider(height: 4, color: Colors.white24)
            : const SizedBox.shrink(),
        subtitle: menuGroup.showHeader && isExpanded
            ? Text(
                menuGroup.subtitle,
                style: effectiveStyle.sidebarStyle?.groupSubtitleStyle,
              )
            : null,
        backgroundColor: Colors.transparent,
        initiallyExpanded: true,
        showTrailingIcon: false,
        tilePadding: isExpanded
            ? effectiveStyle.sidebarStyle?.groupPadding
            : EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        children: menuGroup.menus
            .map(
              (menuModel) => Padding(
                padding:
                    effectiveStyle.sidebarStyle?.itemPadding ?? EdgeInsets.zero,
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
            ? buildDrawerExpandedLogo(
                context: context,
                effectiveStyle: effectiveStyle,
              )
            : buildDrawerCollapsedLogo(
                context: context,
                effectiveStyle: effectiveStyle,
              ),
      ),
      onTap: onToggle,
    );
  }
}
