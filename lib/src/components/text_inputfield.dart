import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:word_score_keeper_app/src/constants/constants.dart';

import '../formatters/formatters.dart';

class TextInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputFormatter? formatter;

  const TextInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.formatter,
  });

  @override
  TextInputFieldState createState() => TextInputFieldState();
}

class TextInputFieldState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade500),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          fillColor: Colors.grey[100],
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
        inputFormatters: [
          widget.formatter ?? getWordFormatter(),
        ],
        maxLength: maxInputLength.length,
      ),
    );
  }
}
