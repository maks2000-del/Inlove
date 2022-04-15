import 'package:flutter/material.dart';

Widget SimpleButton(
  Size size,
  String string,
  double width,
  VoidCallback voidCallback,
) {
  return InkWell(
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    onTap: voidCallback,
    child: Container(
      height: size.width / 8,
      width: size.width / width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xff4796ff),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        string,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    ),
  );
}
