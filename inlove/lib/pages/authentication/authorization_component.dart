import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inlove/models/entities/internet_connection.dart';
import 'package:inlove/pages/authentication/authentication_cubit.dart';
import 'package:inlove/repository/couple_repository.dart';
import 'package:inlove/repository/user_repository.dart';

import '../../components/button.dart';
import '../../components/input_textfield.dart';
import '../../injector.dart';

Widget authorizationComponent({
  required Size size,
  required Animation<double> opacity,
  required Animation<double> transform,
  required AuthorizationCubit authorizationCubit,
  required VoidCallback openMainPage,
  required TextEditingController nameFieldController,
  required TextEditingController mailFieldController,
  required TextEditingController passwordFieldController,
  required UserPerository userPerository,
  required CoupleRepository coupleRepository,
}) {
  final _internetConnection = locator.get<InternetConnection>();

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
                inputTextfield(
                  size: size,
                  icon: Icons.email_outlined,
                  hintText: 'Email...',
                  isPassword: false,
                  isEmail: true,
                  inputController: mailFieldController,
                ),
                inputTextfield(
                  size: size,
                  icon: Icons.lock_outline,
                  hintText: 'Password...',
                  isPassword: true,
                  isEmail: false,
                  inputController: passwordFieldController,
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
                            authorizationCubit.switchRegAuthComponent();
                          },
                      ),
                    ),
                    SizedBox(width: size.width / 25),
                    simpleButton(
                      size,
                      'LOGIN',
                      20.0,
                      () async {
                        final sharedPreferencesProvider =
                            await authorizationCubit
                                .registerSharedPreferences();

                        final mail = mailFieldController.text;
                        final password = passwordFieldController.text;

                        _internetConnection.status
                            ? authorizationCubit.internetAuth(
                                mail: mail,
                                password: password,
                                userPerository: userPerository,
                                coupleRepository: coupleRepository,
                                sp: sharedPreferencesProvider,
                                openMainPage: openMainPage,
                              )
                            : authorizationCubit.localAuth(
                                mail: mail,
                                password: password,
                                sp: sharedPreferencesProvider,
                                openMainPage: openMainPage,
                              );
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
