import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String label;
  final Function onChange;
  final bool password;
  final TextEditingController controller;

  const InputTextField({
    Key key,
    this.label,
    this.onChange,
    this.password = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChange,
      obscureText: password,
      cursorColor: Colors.grey,
      style: TextStyle(color: Colors.white.withOpacity(0.85)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
        border: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
          width: 2,
        )),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
          width: 2,
        )),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.grey,
          width: 0.5,
        )),
      ),
    );
  }
}
