import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final double height;
  final double bordRadious;
  final Color textColor;
  final VoidCallback onPress;

  // ignore: use_key_in_widget_constructors
  const CustomElevatedButton(
      {required this.child,
      required this.color,
      this.height = 50.0,
      this.bordRadious = 2.0,
      required this.textColor,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: textColor,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(bordRadious),
          ),
          
        ),
        child: child,
      ),
    );
  }
}