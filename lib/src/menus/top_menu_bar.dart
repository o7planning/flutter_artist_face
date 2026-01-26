part of '../face_screen.dart';

class TopMenuBar extends StatelessWidget implements PreferredSizeWidget {
  final EdgeInsets? contentPadding;
  final Widget Function(BuildContext context, MenuDrawerController controller)
  buildTopMenuShowHideDrawerButton;

  //
  final Widget Function(BuildContext context)? buildTopMenuProfile;

  final List<Widget> Function(BuildContext context)
  buildTopMenuCenterRightMenuItems;

  final Widget? Function(BuildContext context) buildTopMenuTitle;

  const TopMenuBar({
    this.contentPadding,
    required this.buildTopMenuTitle,
    required this.buildTopMenuShowHideDrawerButton,
    required this.buildTopMenuCenterRightMenuItems,
    required this.buildTopMenuProfile,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget? titleWidget = buildTopMenuTitle(context);

    return Container(
      padding:
          contentPadding ??
          const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: const Border(
          bottom: BorderSide(color: Colors.black38, width: 0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildTopMenuShowHideDrawerButton(context, _menuDrawerController),
          if (titleWidget != null) Expanded(child: titleWidget),
          ...buildTopMenuCenterRightMenuItems(context),
          if (buildTopMenuProfile != null) buildTopMenuProfile!(context),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(Dimensions.webMaxWidth, 80);
}
