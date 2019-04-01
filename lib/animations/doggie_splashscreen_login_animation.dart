import 'package:flutter/material.dart';

class DoggieSplashScreenLoginAnimation {


  DoggieSplashScreenLoginAnimation(this.controller, this.size):

  logoScale = new Tween(begin: 1.0, end: .5).animate(
      new CurvedAnimation(parent: controller, curve: Interval(0.0, 0.20, curve: Curves.elasticIn))
  ),

  reduceLogoContainerHeight = new Tween(begin: size.height, end: size.height/2).animate(
      new CurvedAnimation(parent: controller, curve: Interval(0.20, 0.25, curve: Curves.easeInOutQuad))
  ),

  textOpacity1 = new Tween(begin: 0.0, end: 1.0).animate(
  new CurvedAnimation(parent: controller, curve: Interval(0.25, 0.35, curve: Curves.easeIn))
  ),

  textOpacity2 = new Tween(begin: 0.0, end: 1.0).animate(
      new CurvedAnimation(parent: controller, curve: Interval(0.28, 0.35, curve: Curves.easeInExpo))
  ),

  increaseLoginContainerHeight = new Tween(begin: size.height, end: size.height/2).animate(
      new CurvedAnimation(parent: controller, curve: Interval(0.30, 0.32, curve: Curves.bounceOut))
  ),

  loginContainerScale = new Tween(begin: 0.0, end: 1.0).animate(
      new CurvedAnimation(parent: controller, curve: Interval(0.37, 0.50, curve: Curves.elasticOut))
  );



  final Size size;
  final AnimationController controller;
  final Animation<double> logoScale;
  final Animation<double> reduceLogoContainerHeight;
  final Animation<double> increaseLoginContainerHeight;
  final Animation<double> loginContainerScale;
  final Animation<double> textOpacity1;
  final Animation<double> textOpacity2;
}