import 'package:flutter/material.dart';

class KeyboardHelper {
  static void hideKeyBoard(BuildContext context) {
    if (FocusManager.instance.primaryFocus?.hasFocus ?? false) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}