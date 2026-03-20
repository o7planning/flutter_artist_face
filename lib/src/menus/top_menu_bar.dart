part of '../face_screen.dart';

/// The horizontal navigation bar at the top of the application.
/// Strictly follows a stateless pattern, receiving data via constructor.
class TopMenuBar extends StatelessWidget {
  final bool isMobile;
  final bool isMenuDrawerExpanded;

  /// Callback to notify the parent when the menu toggle is pressed.
  final VoidCallback onToggleMenuDrawer;

  final Widget Function(BuildContext context) buildTopMenuLeading;
  final Widget Function(BuildContext context) buildTopMenuCenter;
  final Widget Function(BuildContext context) buildTopMenuTrailing;

  const TopMenuBar({
    super.key,
    required this.isMobile,
    required this.isMenuDrawerExpanded,
    required this.onToggleMenuDrawer,
    required this.buildTopMenuLeading,
    required this.buildTopMenuCenter,
    required this.buildTopMenuTrailing,
  });

  @override
  Widget build(BuildContext context) {
    return InternalCustomAppContainer(
      height: 60,
      margin: const EdgeInsets.only(bottom: 0),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      borderRadius: 0,
      border: const Border(
        bottom: BorderSide(color: Colors.black12, width: 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Left Section: Toggle Button and Leading Widgets
          Row(
            children: [
              IconButton(
                onPressed: () {
                  if (isMobile) {
                    Scaffold.of(context).openDrawer();
                  } else {
                    onToggleMenuDrawer();
                  }
                },
                icon: Icon(
                  isMobile
                      ? Icons.menu
                      : (isMenuDrawerExpanded ? Icons.menu_open : Icons.menu),
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 8),
              buildTopMenuLeading(context),
            ],
          ),

          /// Center Section
          Expanded(child: buildTopMenuCenter(context)),

          /// Right Section: Trailing Widgets (Profile, Notifications, etc.)
          buildTopMenuTrailing(context),
        ],
      ),
    );
  }
}
