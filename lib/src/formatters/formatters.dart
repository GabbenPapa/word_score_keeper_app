import 'package:flutter/services.dart';

TextInputFormatter getWordFormatter() {
  return FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'));
}
