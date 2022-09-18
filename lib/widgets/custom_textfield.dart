import 'package:flutter/material.dart';
import 'package:twitch_clone_tutorial/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onTap;
 final String? Function(String?)? validator;
  const CustomTextField({
    Key? key,
    required this.controller,
    this.onTap,
    this.validator
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:validator ,
      onFieldSubmitted: onTap,
      controller: controller,
      decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
            // borderSide: BorderSide(
            //   color: buttonColor,
            //   width: 2,
            // ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: secondaryBackgroundColor,
            ),
          )),
    );
  }
}
