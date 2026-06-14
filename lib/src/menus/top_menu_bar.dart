part of '../face_screen.dart';

/// An enterprise-grade navigation appbar layout component that orchestrates adaptive
/// horizontal header areas for full-frame dashboard panels.
///
/// Built as a core presentation asset within the `FlutterArtist` framework, [TopMenuBar] automatically
/// coordinates responsive navigation state flips via ambient callbacks, routing mobile viewports to open
/// structural drawers while allowing desktop contexts to toggle vertical sidebar panels smoothly.
class TopMenuBar extends StatelessWidget {
  /// The global active theme token property enforcing decorative styles, background color schemes,
  /// and custom iconography colors across header partitions.
  final FaceStyle effectiveStyle;

  /// Flags whether the hosting device conforms to a compact viewport constraints matrix,
  /// dynamically shifting layout behavior rules and touch-first interaction scopes.
  final bool isMobile;

  /// Dictates if the auxiliary sidebar component is currently fully extended to broad visual limits
  /// or minimized into narrow icon-only command lanes.
  final bool isSidebarExpanded;

  /// Fires a custom programmatic execution handler callback upstream immediately upon
  /// intercepting toggle clicks in non-mobile viewports.
  final VoidCallback onToggleSidebar;

  /// A structural layout builder compiling visual branding graphics, back buttons,
  /// or title texts near the leading boundary of the header bar strip.
  final Widget Function({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  })
  buildTopMenuLeading;

  /// A structural layout builder filling out the centralized segment track of the header bar canvas,
  /// commonly deployed to host search bars, workspace indicators, or tab viewports.
  final Widget Function({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  })
  buildTopMenuCenter;

  /// A structural layout builder compiling system quick tools, profile badges, notification triggers,
  /// or diagnostic status monitors at the absolute end boundary lane.
  final Widget Function({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  })
  buildTopMenuTrailing;

  /// Constructs a standard, production-ready immutable declarative instance of [TopMenuBar]
  /// with explicit structure parameters.
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
