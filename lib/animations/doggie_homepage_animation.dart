import 'package:flutter/material.dart';

class DoggieHomepageAnimation {

  DoggieHomepageAnimation(this.controller, this.size): flipHamburgerMenu = new Tween<double>(begin: 0.0, end: 1.0).animate(
    new CurvedAnimation(parent: controller, curve: Curves.elasticIn)
  ),

  growAppBar = new Tween<double>(begin: 118.0, end: 150.0).animate(
      new CurvedAnimation(parent: controller, curve: Interval(0.0, 0.2, curve: Curves.bounceOut))
  ),

  searchIn = new Tween<double>(begin: 0.0, end: 1.0).animate(
      new CurvedAnimation(parent: controller, curve: Interval(0.3, 0.9, curve: Curves.elasticOut))
  );

  Size size;
  final AnimationController controller;
  final Animation<double> flipHamburgerMenu;
  final Animation<double> searchIn;
  final Animation<double> growAppBar;
}