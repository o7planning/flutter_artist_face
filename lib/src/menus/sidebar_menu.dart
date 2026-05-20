part of '../face_screen.dart';

class SidebarMenu extends StatelessWidget {
  final List<SidebarMenuGroupModel> sidebarMenuGroupModels;
  final SidebarMenuItemModel? configurationMenuItemModel;
  final Widget Function({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  })
  buildSidebarExpandedProfile;
  final Widget Function({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  })
  buildSidebarCollapsedProfile;
  final Widget Function({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  })
  buildSidebarExpandedLogo;
  final Widget Function({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  })
  buildSidebarCollapsedLogo;
  final bool isExpanded;
  final bool isMobile;
  final FaceStyle effectiveStyle;
  final VoidCallback onToggle;
  final Function(SidebarMenuItemModel menuModel) onMenuItemTap;

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
        color: effectiveStyle
            .sidebarStyle
            .backgroundColor, // Ép sử dụng cấu hình độc lập từ FaceStyle
        boxShadow: null,
      ),
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
