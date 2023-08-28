import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({required this.hint, this.onChange, this.obsecure = false});
  String? hint;
  Function(String)? onChange;
  bool? obsecure;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: TextFormField(
        obscureText: obsecure!,
        validator: (data) {
          if (data!.isEmpty) {
            return "Value Is Wrong";
          }
        },
        onChanged: onChange,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle:const TextStyle(
              color: Colors.white,
            ),
            enabledBorder:const OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white,
            )),
            border:const OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white,
            ))),
      ),
    );
  }
}
