import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool showAction;
  final IconData actionIcon;
  final String actionText;
  final VoidCallback? onAction;

  const NoDataWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.showAction = false,
    this.actionIcon = Icons.add,
    this.actionText = 'إضافة',
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1E6553);
    const textColor = Color(0xFF2D3748);
    const mutedColor = Color(0xFF718096);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE7EBE8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 42,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: mutedColor,
              fontSize: 12,
            ),
          ),
          if (showAction) ...[
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: onAction,
              icon: Icon(actionIcon),
              label: Text(actionText),
              style: OutlinedButton.styleFrom(
                foregroundColor: primaryColor,
                side: const BorderSide(
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
