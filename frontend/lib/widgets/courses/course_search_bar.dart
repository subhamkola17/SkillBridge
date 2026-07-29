import 'package:flutter/material.dart';

class CourseSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const CourseSearchBar({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        cursorColor: Colors.blue,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: "Search courses...",
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.blue,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              controller.clear();
              if (onChanged != null) {
                onChanged!('');
              }
            },
            icon: const Icon(
              Icons.close,
              color: Colors.grey,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}