import 'package:flutter/material.dart';

import '../helper/dimensions.dart';

/// An enterprise-grade, custom action utility button with integrated real-time
/// notification badge tracking designed for top navigation header bars.
///
/// Built inside the `FlutterArtist` package ecosystem, [TopMenuItemButton] coordinates layout positioning
/// using a structural [Stack] to render custom icon elements inside a modern circular border while overlaying
/// dynamic counter badges at designated quadrants safely.
class TopMenuItemButton extends StatelessWidget {
  /// The functional component graphic or vector emblem rendered inside the center circle boundary canvas.
  final Widget icon;

  /// Holds numeric value metrics feeding the interactive indicator badge counter.
  ///
  /// The dynamic badge layout automatically unmounts from the rendering tree if this parameter
  /// is configured as `null` or falls below `1`.
  final int? notificationValue;

  /// The decorative paint coloring applied to fill the background box of the active notification badge.
  final Color notificationBgColor;

  /// The typographic paint color profile mapped over the text string displaying the notice counter digits.
  final Color notificationColor;

  /// Fires a custom programmatic execution handler closure immediately upon intercepting tap gesture events.
  final Function() onTap;

  /// Constructs a standard, production-ready immutable declarative instance of [TopMenuItemButton].
  const TopMenuItemButton({
    super.key,
    required this.icon,
    this.notificationValue,
    this.notificationBgColor = Colors.red,
    this.notificationColor = Colors.white,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  shape: BoxShape.circle,
                ),
                child: icon,
              ),
              const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            ],
          ),
        ),
        if (notificationValue != null && notificationValue! > 0)
          Positioned(right: 3, bottom: -3, child: _buildNotificationValue()),
      ],
    );
  }

  /// Internal structural builder layout method compiling the localized badge container box asset.
  Widget _buildNotificationValue() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 0),
      decoration: BoxDecoration(
        color: notificationBgColor,
        border: Border.all(color: Colors.pink),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        notificationValue.toString(),
        style: TextStyle(fontSize: 10, color: notificationColor),
      ),
    );
  }
}
