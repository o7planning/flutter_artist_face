import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import 'menu_drawer_style.dart';
import 'menu_model.dart';

/// A single interactive item within the MenuDrawer.
/// This widget is now purely presentational, relying on its parent for state and actions.
class MenuItem extends StatefulWidget {
  final DrawerMenuItemModel menuModel;
  final bool isExpanded;
  final bool isMobile;
  final MenuDrawerStyle style;

  /// Callback triggered when the item is tapped.
  final VoidCallback onTap;

  /// Standardized icon size for the menu system.
  static const double menuIconSize = 18;

  const MenuItem({
    super.key,
    required this.menuModel,
    required this.isExpanded,
    required this.isMobile,
    required this.style,
    required this.onTap,
  });

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    /// Selection state is now strictly driven by the data model.
    final bool isSelected = widget.menuModel.isSelected;
    final style = widget.style;

    return MouseRegion(
      onEnter: (event) => setState(() => _isHovered = true),
      onExit: (event) => setState(() => _isHovered = false),
      child: Container(
        decoration: BoxDecoration(
          /// Visual feedback for selection and hover states.
          color: isSelected
              ? (style.itemSelectedColor ?? Colors.grey[800]!.withOpacity(0.4))
              : _isHovered
              ? (style.itemHoverColor ?? Colors.grey[800]!.withOpacity(0.2))
              : Colors.transparent,

          border: Border.all(color: Colors.transparent, width: 1),
          borderRadius: BorderRadius.circular(style.itemBorderRadius),
        ),
        child: Material(
          color: Colors.transparent,
          child: ListTile(
            hoverColor: Colors.transparent,
            selectedTileColor: Colors.transparent,
            selected: isSelected,
            dense: true,
            visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
            horizontalTitleGap: 0,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            title: _buildRow(context, isSelected),
            onTap: widget.onTap,
          ),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, bool isSelected) {
    final style = widget.style;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// Tooltip is only shown when the drawer is in collapsed mode.
        widget.isExpanded
            ? _buildMenuIcon()
            : JustTheTooltip(
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.menuModel.menuTitle ?? ''),
                ),
                preferredDirection: AxisDirection.right,
                child: _buildMenuIcon(),
              ),

        if (widget.isMobile || widget.isExpanded) ...[
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              widget.menuModel.menuTitle ?? '',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: style.itemTextColor,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ],

        /// Notification Badge handling.
        if ((widget.isMobile || widget.isExpanded) &&
            widget.menuModel.notifyValue != null)
          _buildNotificationValue(widget.menuModel.notifyValue!),
      ],
    );
  }

  Widget _buildMenuIcon() {
    return Icon(
      widget.menuModel.iconData,
      color: widget.style.itemIconColor,
      size: MenuItem.menuIconSize,
    );
  }

  Widget _buildNotificationValue(int notificationValue) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        notificationValue.toString(),
        style: const TextStyle(fontSize: 10, color: Colors.white),
      ),
    );
  }
}
