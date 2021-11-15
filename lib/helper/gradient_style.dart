import 'dart:ui' as ui;

import 'package:flutter/material.dart';

TextStyle gradientStyle = TextStyle(
    foreground: Paint()
      ..shader = ui.Gradient.linear(const Offset(0, 20), const Offset(150, 20),
          [Colors.yellow[600]!, Colors.red[200]!]));

