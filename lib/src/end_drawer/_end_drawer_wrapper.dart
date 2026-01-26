part of '../base_face_screen.dart';

class _EndDrawerWrapper extends StatefulWidget {
  final double Function(BuildContext context) calculateEndDrawerWidth;
  final Widget? Function(BuildContext context) build;

  const _EndDrawerWrapper({
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
    Widget? endDrawer = widget.build(context);
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
