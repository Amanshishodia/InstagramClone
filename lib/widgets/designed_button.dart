import 'package:flutter/material.dart';
import 'package:insta/utils/colors.dart';

class MyButton extends StatelessWidget {
  final Function onTap;
  final String buttonText;
  const MyButton({super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Center(
            child: Text(
          buttonText,
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: blueColor),
      ),
      onTap: () => onTap(),
    );
  }
}
