import 'package:flutter/material.dart';

extension SizeExtension on Size {
  double get radius => width > height ? height : width;
}
