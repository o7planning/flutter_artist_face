import 'package:flutter/material.dart';

import 'base_face_screen.dart';
import 'helper/dimensions.dart';
import 'helper/responsive_helper.dart';
import 'menus/footer_section.dart';
import 'menus/menu_item.dart';
import 'menus/menu_model.dart';

part 'controller/menu_drawer_controller.dart';
part 'menus/menu_drawer.dart';
part 'menus/top_menu_bar.dart';

abstract class FaceScreen extends BaseFaceScreen {
  const FaceScreen({super.key});

  MenuDrawerController get menuDrawerController => _menuDrawerController;

  @override
  void onDrawerChanged(bool isOpened) {
    _menuDrawerController.setExpanded(expanded: isOpened);
  }

  @override
  Widget buildDrawer(BuildContext context) {
    return MenuDrawer(
      configurationMenuItemModel: getConfigurationDrawerMenuItemModel(),
      drawerMenuGroupModels: getDrawerMenuGroupModels(),
      buildDrawerExpandedProfile: buildDrawerExpandedProfile,
      buildDrawerCollapsedProfile: buildDrawerCollapsedProfile,
      buildDrawerExpandedLogo: buildDrawerExpandedLogo,
      buildDrawerCollapsedLogo: buildDrawerCollapsedLogo,
    );
  }

  @override
  Widget buildTopMenuBar(BuildContext context) {
    return TopMenuBar(
      contentPadding: getTopMenuContentPadding(),
      buildTopMenuProfile: buildTopMenuProfile,
      buildTopMenuTitle: buildTopMenuTitle,
      buildTopMenuShowHideDrawerButton: buildTopMenuShowHideDrawerButton,
      buildTopMenuCenterRightMenuItems: buildTopMenuCenterRightMenuItems,
    );
  }

  @override
  Widget buildFooter(BuildContext context) {
    return const FooterSection();
  }

  // ***************************************************************************
  // **************   MENU DRAWER   **************
  // ***************************************************************************

  List<DrawerMenuGroupModel> getDrawerMenuGroupModels();

  EdgeInsets? getTopMenuContentPadding();

  DrawerMenuItemModel? getConfigurationDrawerMenuItemModel();

  Widget buildDrawerExpandedProfile(BuildContext context);

  Widget buildDrawerCollapsedProfile(BuildContext context);

  Widget buildDrawerExpandedLogo(BuildContext context);

  Widget buildDrawerCollapsedLogo(BuildContext context);

  // ***************************************************************************
  // **************   TOP DRAWER   **************
  // ***************************************************************************

  Widget buildTopMenuShowHideDrawerButton(
    BuildContext context,
    MenuDrawerController menuDrawerController,
  );

  Widget buildTopMenuTitle(BuildContext context);

  List<Widget> buildTopMenuCenterRightMenuItems(BuildContext context);

  Widget buildTopMenuProfile(BuildContext context);
}
