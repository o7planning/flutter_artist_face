import 'package:flutter/material.dart';

import 'helper/responsive_helper.dart';
import 'widget/internal_custom_app_container.dart';

part 'end_drawer/_end_drawer_wrapper.dart';

abstract class BaseFaceScreen extends StatelessWidget {
  const BaseFaceScreen({super.key});

  Widget buildMainContent(BuildContext context);

  void onDrawerChanged(bool isOpened);

  void onEndDrawerChanged(bool isOpened) {
    // Override me if need.
  }

  Widget buildDrawer(BuildContext context);

  ///
  /// By default the width of EndDrawer is 320,
  /// if you want to specify a different value
  /// you need to "override" the [calculateEndDrawerWidth] method.
  ///
  Widget? buildEndDrawer(BuildContext context) {
    return null;
  }

  double calculateEndDrawerWidth(BuildContext context) {
    return 320;
  }

  Widget buildTopMenuBar(BuildContext context);

  Widget buildFooter(BuildContext context);

  _EndDrawerWrapper? _buildEndDrawer(BuildContext context) {
    _EndDrawerWrapper? endDrawerWrap = _EndDrawerWrapper(
      calculateEndDrawerWidth: calculateEndDrawerWidth,
      build: buildEndDrawer,
    );
    return endDrawerWrap;
  }

  void _onEndDrawerChanged(bool isOpened) {
    onEndDrawerChanged(isOpened);
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveHelper.isMobile(context);
    //
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      drawer: isMobile ? buildDrawer(context) : null,
      endDrawer: _buildEndDrawer(context),
      onDrawerChanged: onDrawerChanged,
      onEndDrawerChanged: _onEndDrawerChanged,
      body: Builder(
        builder: (BuildContext ctx) {
          return Row(
            children: [
              if (!isMobile) buildDrawer(ctx),
              Expanded(child: _buildRightSection(ctx)),
            ],
          );
        },
      ),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  Widget _buildRightSection(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildTopMenuBar(context),
        Expanded(child: buildMainContent(context)),
      ],
    );
  }

  Widget? buildFloatingActionButton(BuildContext context) {
    return null;
  }
}
