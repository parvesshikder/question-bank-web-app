import 'package:flutter/material.dart';
import 'package:questionbankleggasi/2_application/core/constants/constants.dart';

SizedBox HeroTextDetails(double deviceWidth, double fontS) {
  return SizedBox(
    width: deviceWidth / 2.2,
    child:  Text(
      '''LEGASI is your key to unlocking a world of curated questions and answers across diverse subjects. Explore, learn, and enrich your understanding effortlessly. With a secure payment system, you can access and download your chosen content, making your learning journey seamless and flexible. ''',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontS,
        fontWeight: FontWeight.w400,
        color: greyext, // Text color for the gradient effect
      ),
    ),
  );
}
