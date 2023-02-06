import 'dart:developer';

import 'package:flutter/material.dart';

double? getHeightByKey(GlobalKey key) {
    try {
      final box = key.currentContext?.findRenderObject() as RenderBox;
      final pos = box.localToGlobal(Offset.zero);
      return box.size.height;
    } catch (e, stacktrace) {
      log(e.toString());
      log(stacktrace.toString());
    }
  return null;
}