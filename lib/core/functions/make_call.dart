import 'package:flutter/material.dart';
import 'package:quran_tahfez/core/widgets/snack.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> makePhoneCall(
  BuildContext context, {
  required String phone,
}) async {
  final cleanedPhone = phone.trim().replaceAll(
    RegExp(r'[\s()-]'),
    '',
  );

  if (cleanedPhone.isEmpty) return;

  final uri = Uri(
    scheme: 'tel',
    path: cleanedPhone,
  );

  try {
    final launched = await launchUrl(uri);

    if (!launched && context.mounted) {
      _showMessage(context, 'تعذر فتح تطبيق الاتصال');
    }
  } catch (_) {
    if (!context.mounted) return;

    _showMessage(context, 'تعذر فتح تطبيق الاتصال');
  }
}

void _showMessage(
  BuildContext context,
  String message,
) {
  Snack.show(context, message: message);
}
