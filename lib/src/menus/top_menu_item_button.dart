import 'package:flutter/material.dart';

import '../helper/dimensions.dart';

class TopMenuItemButton extends StatelessWidget {
  final Widget icon;
  final int? notificationValue;
  final Color notificationBgColor;
  final Color notificationColor;
  final Function() onTap;

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
