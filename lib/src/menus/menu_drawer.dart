part of '../face_screen.dart';

class MenuDrawer extends StatelessWidget {
  final List<DrawerMenuGroupModel> drawerMenuGroupModels;
  final DrawerMenuItemModel? configurationMenuItemModel;
  final Widget Function(BuildContext context) buildDrawerExpandedProfile;
  final Widget Function(BuildContext context) buildDrawerCollapsedProfile;
  final Widget Function(BuildContext context) buildDrawerExpandedLogo;
  final Widget Function(BuildContext context) buildDrawerCollapsedLogo;

  final bool isExpanded;
  final bool isMobile;
  final MenuDrawerStyle style;
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
    this.style = const MenuDrawerStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isExpanded ? style.expandedWidth : style.collapsedWidth,
      color: style.backgroundColor,
      child: Column(
        children: [
          _buildControlTile(context: context),
          isExpanded
              ? buildDrawerExpandedProfile(context)
              : buildDrawerCollapsedProfile(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: drawerMenuGroupModels
                    .map((group) => _buildMenuGroup(context, group))
                    .toList(),
              ),
            ),
          ),
          if (configurationMenuItemModel != null)
            Padding(
              padding: isExpanded
                  ? style.groupPadding
                  : const EdgeInsets.all(5),
              child: MenuItem(
                menuModel: configurationMenuItemModel!,
                isExpanded: isExpanded,
                isMobile: isMobile,
                style: style,
                onTap: () => onMenuItemTap(configurationMenuItemModel!),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMenuGroup(BuildContext context, DrawerMenuGroupModel menuGroup) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        minTileHeight: 0,
        enabled: menuGroup.showHeader,
        title: menuGroup.showHeader && isExpanded
            ? Text(menuGroup.title, style: style.groupTitleStyle)
            : menuGroup.showHeader
            ? const Divider(height: 4, color: Colors.white24)
            : const SizedBox.shrink(),
        subtitle: menuGroup.showHeader && isExpanded
            ? Text(menuGroup.subtitle, style: style.groupSubtitleStyle)
            : null,
        backgroundColor: Colors.transparent,
        initiallyExpanded: true,
        showTrailingIcon: false,
        tilePadding: isExpanded ? style.groupPadding : EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        children: menuGroup.menus
            .map(
              (menuModel) => Padding(
                padding: style.itemPadding,
                child: MenuItem(
                  menuModel: menuModel,
                  isExpanded: isExpanded,
                  isMobile: isMobile,
                  style: style,
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
            ? buildDrawerExpandedLogo(context)
            : buildDrawerCollapsedLogo(context),
      ),
      onTap: onToggle,
    );
  }
}
