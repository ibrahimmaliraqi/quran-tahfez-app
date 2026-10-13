import 'package:flutter/material.dart';

class TeachersSearchField extends StatelessWidget {
  // final TextEditingController controller;
  // final ValueChanged<String> onChanged;

  const TeachersSearchField({
    super.key,
    // required this.controller,
    // required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      // controller: controller,
      // onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'ابحث عن اسم المعلم أو البريد',
        hintStyle: const TextStyle(
          color: Color(0xFF8A948F),
          fontSize: 13,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: Color(0xFF1E6553),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE4E9E5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE4E9E5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFF1E6553),
            width: 1.3,
          ),
        ),
      ),
    );
  }
}
