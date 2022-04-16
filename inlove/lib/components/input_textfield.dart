import 'package:flutter/material.dart';

Widget InputTextfield({
  required Size size,
  required IconData icon,
  required String hintText,
  required bool isPassword,
  required bool isEmail,
  required TextEditingController inputController,
}) {
  return Container(
    height: size.width / 8,
    width: size.width / 1.22,
    alignment: Alignment.center,
    padding: EdgeInsets.only(right: size.width / 30),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(.05),
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextField(
      controller: inputController,
      style: TextStyle(color: Colors.black.withOpacity(.8)),
      obscureText: isPassword,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.black.withOpacity(.7),
        ),
        border: InputBorder.none,
        hintMaxLines: 1,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
        suffixIcon: inputController.text.isEmpty
            ? null
            : IconButton(
                onPressed: inputController.clear,
                icon: Icon(Icons.clear),
              ),
      ),
      onChanged: null,
    ),
  );
}
