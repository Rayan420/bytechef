// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';

class PostField extends StatelessWidget {
  const PostField({
    super.key,
    required this.controller,
    required this.hintText,
  });
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.1, // Set desired width here
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200], // Background color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 219, 219, 219),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey, // Grey border color
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText, // Hint text
          hintStyle: TextStyle(
            color: Colors.grey,
            fontFamily: 'Poppins',
            fontSize: 12,
          ), // Hint text color
        ),
      ),
    );
  }
}
