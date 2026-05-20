import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'platform/stub.dart'
    if (dart.library.io) 'platform/native.dart'
    if (dart.library.js_interop) 'platform/web.dart';

class ResponsiveHelper {
  static bool isDesktopPlatform() {
    if (kIsWeb) return false;
    return isDesktopPlatformId;
  }

  static bool isMobilePhone() {
    return !kIsWeb;
  }

  static bool isWeb() {
    return kIsWeb;
  }

  static bool isMobileWidth(double width) {
    return width < 850;
  }

  static bool isTabletWidth(double width) {
    return width < 1100 && width >= 850;
  }

  static bool isDesktopWidth(double width) {
    return width >= 1100;
  }

  static bool isMobile(BuildContext context) {
    final size = MediaQuery.sizeOf(context).width;

    if (size < 850) return true;
    if (kIsWeb) return false;
    if (isDesktopPlatform()) return false;

    return true;
  }

  static bool isTab(BuildContext context) {
    final size = MediaQuery.sizeOf(context).width;
    return size < 1100 && size >= 850;
  }

  static bool isDesktop(BuildContext context) {
    final size = MediaQuery.sizeOf(context).width;
    return size >= 1100;
  }
}
