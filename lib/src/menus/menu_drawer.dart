part of '../face_screen.dart';

final _menuDrawerController = MenuDrawerController();

class MenuDrawer extends StatefulWidget {
  final List<DrawerMenuGroupModel> drawerMenuGroupModels;
  final DrawerMenuItemModel? configurationMenuItemModel;
  final Widget Function(BuildContext context) buildDrawerExpandedProfile;
  final Widget Function(BuildContext context) buildDrawerCollapsedProfile;
  final Widget Function(BuildContext context) buildDrawerExpandedLogo;
  final Widget Function(BuildContext context) buildDrawerCollapsedLogo;

  const MenuDrawer({
    super.key,
    required this.drawerMenuGroupModels,
    required this.configurationMenuItemModel,
    required this.buildDrawerExpandedProfile,
    required this.buildDrawerCollapsedProfile,
    required this.buildDrawerExpandedLogo,
    required this.buildDrawerCollapsedLogo,
  });

  @override
  State<StatefulWidget> createState() {
    return _MenuDrawerState();
  }
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  void initState() {
    super.initState();
    _menuDrawerController._addStateListener(this);
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveHelper.isMobile(context);
    //
    return _buildMenuDrawer(
      context,
      isMobile: isMobile,
      isExpanded: _menuDrawerController.isExpanded,
    );
  }

  EdgeInsets _getOutsidePadding(bool isExpanded) {
    return isExpanded
        ? const EdgeInsets.fromLTRB(15, 0, 15, 5)
        : const EdgeInsets.fromLTRB(5, 0, 5, 5);
  }

  Widget _buildMenuDrawer(
    BuildContext context, {
    required bool isMobile,
    required bool isExpanded,
  }) {
    return Container(
      width: isExpanded ? 240 : 50,
      color:
          isExpanded
              ? const Color.fromARGB(255, 15, 23, 42)
              : const Color.fromARGB(255, 15, 23, 42),
      child: Column(
        children: [
          _buildControlTile(
            context: context,
            isMobile: isMobile,
            isExpanded: isExpanded,
          ),
          if (isExpanded) widget.buildDrawerExpandedProfile(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children:
                    widget.drawerMenuGroupModels
                        .map(
                          (menuGroup) => _buildMenuGroup(
                            context,
                            menuGroup: menuGroup,
                            isMobile: isMobile,
                            isExpanded: isExpanded,
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
          if (widget.configurationMenuItemModel != null)
            Padding(
              padding: _getOutsidePadding(isExpanded),
              child: _buildMenu(
                context,
                menuModel: widget.configurationMenuItemModel!,
                isMobile: isMobile,
                isExpanded: isExpanded,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMenuGroup(
    BuildContext context, {
    required DrawerMenuGroupModel menuGroup,
    required bool isMobile,
    required bool isExpanded,
  }) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        minTileHeight: 0,
        enabled: menuGroup.showHeader,
        title:
            menuGroup.showHeader && isExpanded
                ? Text(
                  menuGroup.title, // (***)
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.lightBlue,
                  ),
                )
                : menuGroup.showHeader
                ? const Divider(height: 4)
                : SizedBox(height: 0),
        subtitle:
            menuGroup.showHeader && isExpanded
                ? Text(
                  menuGroup.subtitle,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
                )
                : null,
        backgroundColor: Colors.transparent,
        initiallyExpanded: true,
        showTrailingIcon: false,
        tilePadding: _getOutsidePadding(isExpanded),
        childrenPadding: _getOutsidePadding(isExpanded),
        children:
            menuGroup.menus
                .map(
                  (menuModel) => _buildMenu(
                    context,
                    menuModel: menuModel,
                    isMobile: isMobile,
                    isExpanded: isExpanded,
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _buildMenu(
    BuildContext context, {
    required DrawerMenuItemModel menuModel,
    required bool isMobile,
    required bool isExpanded,
  }) {
    return MenuItem(
      menuModel: menuModel,
      isExpanded: isExpanded,
      isMobile: isMobile,
    );
  }

  Widget _buildControlTile({
    required BuildContext context,
    required bool isMobile,
    required bool isExpanded,
  }) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
      minVerticalPadding: 10,
      contentPadding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
      title: Align(
        alignment: Alignment.centerLeft,
        child:
            isMobile || isExpanded
                ? widget.buildDrawerExpandedLogo(context)
                : widget.buildDrawerCollapsedLogo(context),
      ),
      onTap: () {
        if (isMobile) {
          Scaffold.of(context).closeDrawer();
        } else {
          _menuDrawerController.toggle();
        }
      },
    );
  }
}
