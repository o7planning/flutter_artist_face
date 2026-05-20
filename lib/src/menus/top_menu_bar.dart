part of '../face_screen.dart';

/// The horizontal navigation bar at the top of the application.
/// Strictly follows a stateless pattern, receiving data via constructor.
class TopMenuBar extends StatelessWidget {
  final FaceStyle effectiveStyle;
  final bool isMobile;
  final bool isSidebarExpanded;
  final VoidCallback onToggleSidebar;
  final Widget Function({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  })
  buildTopMenuLeading;
  final Widget Function({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  })
  buildTopMenuCenter;
  final Widget Function({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  })
  buildTopMenuTrailing;

  const TopMenuBar({
    super.key,
    required this.effectiveStyle,
    required this.isMobile,
    required this.isSidebarExpanded,
    required this.onToggleSidebar,
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
      color: effectiveStyle.topbarStyle.backgroundColor,
      borderRadius: 0,
      border: const Border(
        bottom: BorderSide(color: Colors.black12, width: 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  if (isMobile) {
                    Scaffold.of(context).openDrawer();
                  } else {
                    onToggleSidebar();
                  }
                },
                icon: Icon(
                  isMobile
                      ? Icons.menu
                      : (isSidebarExpanded ? Icons.menu_open : Icons.menu),
                  color: effectiveStyle.topbarStyle.iconColor,
                ),
              ),
              const SizedBox(width: 8),
              buildTopMenuLeading(
                context: context,
                effectiveStyle: effectiveStyle,
              ),
            ],
          ),
          Expanded(
            child: buildTopMenuCenter(
              context: context,
              effectiveStyle: effectiveStyle,
            ),
          ),
          buildTopMenuTrailing(
            context: context,
            effectiveStyle: effectiveStyle,
          ),
        ],
      ),
    );
  }
}
