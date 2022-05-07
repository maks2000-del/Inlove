import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Widget simpleButtonOld(
  Size appSize,
  String title,
  double width,
  VoidCallback voidCallback,
) {
  return InkWell(
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    onTap: voidCallback,
    child: Container(
      height: appSize.width / 8,
      width: appSize.width / width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xff4796ff),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    ),
  );
}

Widget simpleButton(
  Size appSize,
  String title,
  double width,
  VoidCallback voidCallback,
) {
  return NeumorphicButton(
    onPressed: voidCallback,
    child: Container(
      height: appSize.width / 12,
      width: appSize.width / 6 + width,
      alignment: Alignment.center,
      child: Text(
        title,
      ),
    ),
  );
}
