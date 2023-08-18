import 'package:flutter/material.dart';

SizedBox HeroText(
    double deviceWidth, String text, LinearGradient color1Gradient) {
  return SizedBox(
    width: deviceWidth / 1.5,
    child: ShaderMask(
      shaderCallback: (Rect bounds) {
        return color1Gradient.createShader(bounds);
      },
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: deviceWidth > 700 ? 38 : 18,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Text color for the gradient effect
        ),
      ),
    ),
  );
}
