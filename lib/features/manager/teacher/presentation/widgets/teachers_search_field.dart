import 'package:flutter/material.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';

class TeachersSearchField extends StatelessWidget {
  /// Both are optional, so the field works today without them
  /// and can be wired to real search later.
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String hint;

  const TeachersSearchField({
    super.key,
    this.controller,
    this.onChanged,
    this.hint = 'ابحث عن اسم المعلم أو البريد',
  });

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primary;

    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: color, width: width),
        );

    Widget field(bool hasText) => TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      cursorColor: primary,
      style: const TextStyle(
        fontSize: 14.5,
        color: Color(0xFF1F342B),
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xFF9AA69D),
          fontSize: 13.5,
        ),
        prefixIcon: Icon(Icons.search_rounded, color: primary, size: 23),
        suffixIcon: hasText
            ? IconButton(
                onPressed: () {
                  controller?.clear();
                  onChanged?.call('');
                },
                icon: const Icon(
                  Icons.close_rounded,
                  size: 19,
                  color: Color(0xFF9AA69D),
                ),
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: border(Colors.transparent),
        enabledBorder: border(Colors.transparent),
        focusedBorder: border(primary.withValues(alpha: 0.55), 1.3),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F342B).withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: controller == null
          ? field(false)
          : ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller!,
              builder: (_, value, __) => field(value.text.isNotEmpty),
            ),
    );
  }
}
