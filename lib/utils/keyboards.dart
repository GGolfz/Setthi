import 'package:flutter/material.dart';

double getKeyboardHeight() {
  return EdgeInsets.fromWindowPadding(WidgetsBinding.instance.window.viewInsets,
          WidgetsBinding.instance.window.devicePixelRatio)
      .bottom;
}
