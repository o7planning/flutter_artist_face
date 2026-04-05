part of '../face_screen.dart';

class _EndDrawerWrapper extends StatefulWidget {
  final FaceStyle effectiveStyle;
  final double Function(BuildContext context) calculateEndDrawerWidth;
  final Widget? Function({
    required BuildContext context,
    required FaceStyle effectiveStyle,
  })
  build;

  const _EndDrawerWrapper({
    required this.effectiveStyle,
    required this.calculateEndDrawerWidth,
    required this.build,
  });

  @override
  State<StatefulWidget> createState() {
    return _EndDrawerWrapperState();
  }
}

class _EndDrawerWrapperState extends State<_EndDrawerWrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget? endDrawer = widget.build(
      context: context,
      effectiveStyle: widget.effectiveStyle,
    );
    return endDrawer == null
        ? SizedBox()
        : InternalCustomAppContainer(
            padding: const EdgeInsets.all(0),
            width: widget.calculateEndDrawerWidth(context),
            height: double.infinity,
            child: endDrawer,
          );
  }
}
