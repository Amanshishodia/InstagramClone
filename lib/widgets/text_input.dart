import 'package:flutter/material.dart';
import 'package:insta/utils/colors.dart';

class TextFieldInput extends StatelessWidget {
  final String hint;
  final String label;
  final bool isPass;
  final TextEditingController textController;
  final TextInputType textInputType;
  const TextFieldInput({super.key,required this.hint,required this.label,required this.textController,required this.isPass,required this.textInputType});

  

  @override
  Widget build(BuildContext context) {
    final InputBorder= OutlineInputBorder(
          borderSide: Divider.createBorderSide(context)
        );
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        hintText: hint,
        label: Text(label,style: TextStyle(color: primaryColor),),
        border: InputBorder,
        focusedBorder: InputBorder,
        enabledBorder: InputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),


      ),
      keyboardType:textInputType ,
      obscureText: isPass ,
    );
  }
}
