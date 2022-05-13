import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

Widget connectionProblemsAnimation() {
  return Center(
    child: Lottie.asset(
      'assets/lottieJSON/no_internet.json',
      width: 400,
      height: 400,
    ),
  );
}
