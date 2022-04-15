import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inlove/pages/authentication/authentication_cubit.dart';

import '../../components/button.dart';
import '../../components/input_textfield.dart';

Widget AuthorizationComponent({
  required Size size,
  required Animation<double> opacity,
  required Animation<double> transform,
  required AuthorizationCubit authorizationCubit,
  required VoidCallback openMainPage,
  required TextEditingController nameFieldController,
  required TextEditingController mailFieldController,
  required TextEditingController passwordFieldController,
}) {
  return SizedBox(
    height: size.height,
    child: Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xffFEC37B),
            Color(0xffFF4184),
          ],
        ),
      ),
      child: Opacity(
        opacity: opacity.value,
        child: Transform.scale(
          scale: transform.value,
          child: Container(
            width: size.width * .9,
            height: size.width * 1.1,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 90,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(),
                Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(.7),
                  ),
                ),
                const SizedBox(),
                InputTextfield(
                  size,
                  Icons.account_circle_outlined,
                  'User name...',
                  false,
                  false,
                  nameFieldController,
                ),
                InputTextfield(
                  size,
                  Icons.email_outlined,
                  'Email...',
                  false,
                  true,
                  mailFieldController,
                ),
                InputTextfield(
                  size,
                  Icons.lock_outline,
                  'Password...',
                  true,
                  false,
                  passwordFieldController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Create a new Account',
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 15,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('syka');
                            Fluttertoast.showToast(
                              msg: 'Create a new Account button pressed',
                            );
                            authorizationCubit.switchRegAuthComponent();
                          },
                      ),
                    ),
                    SizedBox(width: size.width / 25),
                    SimpleButton(
                      size,
                      'LOGIN',
                      2.6,
                      () {
                        //HapticFeedback.lightImpact();
                        //Fluttertoast.showToast(msg: 'Login button pressed');
                        openMainPage();
                      },
                    ),
                  ],
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
