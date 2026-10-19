import 'package:flutter/material.dart';

class PopupMenuItemModel<T> {
  final T value;
  final String title;
  final IconData? icon;
  final Color? color;

  const PopupMenuItemModel({
    required this.value,
    required this.title,
    this.icon,
    this.color,
  });
}

class CustomPopupMenuButton<T> extends StatelessWidget {
  final List<PopupMenuItemModel<T>> items;
  final ValueChanged<T> onSelected;
  final Widget? icon;
  final double? iconSize;
  final Color? iconColor;

  const CustomPopupMenuButton({
    super.key,
    required this.items,
    required this.onSelected,
    this.icon,
    this.iconSize = 24,
    this.iconColor,
    required String value,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      icon:
          icon ??
          Icon(
            Icons.more_vert_rounded,
            size: iconSize,
            color: iconColor ?? const Color(0xFF1E6553),
          ),
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      onSelected: onSelected,
      itemBuilder: (context) {
        return items.map((item) {
          final color = item.color ?? const Color(0xFF2D3748);

          return PopupMenuItem<T>(
            value: item.value,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (item.icon != null) ...[
                  Icon(
                    item.icon,
                    size: 20,
                    color: color,
                  ),
                  const SizedBox(width: 10),
                ],
                Text(
                  item.title,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}
