import 'package:flutter/material.dart';
import 'package:khazana_fintech_task/core/constant/theme/app_color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.maxlines = 1,
      required this.controller,
      required this.validator,
      required this.insidelabel});
  final int maxlines;
  final TextEditingController controller;
  final String insidelabel;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColor.whiteColor,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      maxLines: maxlines,
      controller: controller,
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 64, 64, 65).withOpacity(0.7),
        contentPadding: const EdgeInsets.all(18),
        filled: true,
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.borderColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.borderColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        label: Text(
          insidelabel,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.borderColor, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
