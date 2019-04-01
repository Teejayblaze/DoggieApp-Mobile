import 'package:flutter/material.dart';

class DoggieCurvedEdgedRect extends CustomClipper<Path> {

  Path path = new Path();

  @override
  getClip(Size size) {

    double halfScreenWidth = size.width/2;
    double oneQuarterWidth = size.width/4;

    this.path.lineTo(0.0, size.height - 20);

    this.path.quadraticBezierTo(oneQuarterWidth, size.height, halfScreenWidth, size.height);

    this.path.quadraticBezierTo(size.width - oneQuarterWidth, size.height, size.width, size.height - 20);

    this.path.lineTo(size.width, 0.0);

    this.path.close();

    return this.path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;

}