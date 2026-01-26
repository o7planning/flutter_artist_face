import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/dimensions.dart';
import '../helper/styles.dart';
import 'menu_model.dart';

class MenuItem extends StatefulWidget {
  final DrawerMenuItemModel menuModel;
  final bool isExpanded;
  final bool isMobile;

  static const double menuIconSize = 18;

  const MenuItem({
    super.key,
    required this.menuModel,
    required this.isExpanded,
    required this.isMobile,
  });

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = widget.menuModel.isSelected;
    //
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
      child: MouseRegion(
        onEnter:
            (event) => setState(() {
              _isHovered = true;
            }),
        onExit:
            (event) => setState(() {
              _isHovered = false;
            }),
        child: Container(
          decoration: BoxDecoration(
            color:
                (_isHovered || isSelected)
                    // Màu nền bên trong border khi hover hoặc được chọn
                    ? Colors.grey[800]!.withOpacity(0.4)
                    : Colors.transparent,
            // Không có màu khi không được chọn hoặc hover
            border:
                (_isHovered || isSelected)
                    // Border khi hover hoặc chọn
                    ? Border.all(
                      color: Colors.grey.shade800.withOpacity(0.4),
                      width: 1,
                    )
                    // Không có border khi không hover hoặc chọn
                    : Border.all(color: Colors.transparent, width: 1),

            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          child: Material(
            // Đảm bảo không có màu nền từ Material
            color: Colors.transparent,
            child: ListTile(
              // Không có hover color
              hoverColor: Colors.transparent,
              // Không có màu khi được chọn
              selectedTileColor: Colors.transparent,
              selected: isSelected,
              dense: true,
              visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
              horizontalTitleGap: 0,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeExtraSmall,
              ),
              title: _buildRow(context, isSelected),
              onTap: () {
                if (widget.menuModel.route != null) {
                  Get.offAndToNamed(widget.menuModel.route!);
                } else if (widget.menuModel.externalUrl != null) {
                  openExternalUrl(widget.menuModel.externalUrl!);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openExternalUrl(String externalUrl) async {
    final url = Uri.parse(externalUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
        // webOnlyWindowName: "_self",
      );
    }
  }

  Widget _buildRow(BuildContext context, bool isSelected) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.isExpanded
            ? _menuIcon(
              iconData: widget.menuModel.iconData,
              color: _iconColor(
                context: context,
                isExpanded: widget.isExpanded,
                isSelected: isSelected,
              ),
            )
            : JustTheTooltip(
              content: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                child: Text(widget.menuModel.menuTitle!.tr),
              ),
              preferredDirection: AxisDirection.right,
              child: _menuIcon(
                iconData: widget.menuModel.iconData,
                color: _iconColor(
                  context: context,
                  isExpanded: widget.isExpanded,
                  isSelected: isSelected,
                ),
              ),
            ),
        if (widget.isMobile || widget.isExpanded)
          const SizedBox(width: Dimensions.paddingSizeSmall),
        if (widget.isMobile || widget.isExpanded)
          Text(
            widget.menuModel.menuTitle!.tr,
            style: ubuntuMedium.copyWith(
              color: _textColor(
                context: context,
                isExpanded: widget.isExpanded,
                isSelected: isSelected,
              ),
              fontSize: 12,
            ),
          ),
        if (widget.isExpanded) const Spacer(),
        if ((widget.isMobile || widget.isExpanded) &&
            widget.menuModel.notifyValue != null)
          _buildNotificationValue(widget.menuModel.notifyValue!),
      ],
    );
  }

  Widget _menuIcon({required IconData iconData, required Color color}) {
    return Icon(iconData, color: color, size: MenuItem.menuIconSize);
  }

  Color _iconColor({
    required BuildContext context,
    required bool isExpanded,
    required bool isSelected,
  }) {
    return Colors.white; // Màu của icon
  }

  Color _textColor({
    required BuildContext context,
    required bool isExpanded,
    required bool isSelected,
  }) {
    return Colors.white; // Màu của text
  }

  Widget _buildNotificationValue(int notificationValue) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.pink,
        border: Border.all(color: Colors.pink),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        notificationValue.toString(),
        style: const TextStyle(fontSize: 10, color: Colors.white),
      ),
    );
  }
}
