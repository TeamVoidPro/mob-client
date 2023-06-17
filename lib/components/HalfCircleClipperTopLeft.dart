import 'package:flutter/material.dart';

class HalfCircleClipperTopLeft extends CustomClipper<Path> {
  HalfCircleClipperTopLeft(String s);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(0, size.height / 2, 0, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(HalfCircleClipperTopLeft oldClipper) => false;
}
