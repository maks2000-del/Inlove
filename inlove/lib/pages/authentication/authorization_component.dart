import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:inlove/models/user_model.dart';
import 'package:inlove/pages/authentication/authentication_cubit.dart';

import '../../components/button.dart';
import '../../components/input_textfield.dart';

Widget authorizationComponent({
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
                            Fluttertoast.showToast(
                              msg: 'Create a new Account button pressed',
                            );
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
                        Fluttertoast.showToast(msg: 'Login button pressed');
                        try {
                          final authResponse = await post(
                            Uri.parse('http://10.0.2.2:3001/api/user/auth'),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode(<String, String>{
                              'email': mailFieldController.text,
                              'password': passwordFieldController.text,
                            }),
                          );
                          if (authResponse.statusCode == 200) {
                            User user =
                                User.fromJson(jsonDecode(authResponse.body));
                            Response coupleResponse = await get(Uri.parse(
                                "http://10.0.2.2:3001/api/coupleById/${user.id}"));
                            Map<String, dynamic> couple =
                                jsonDecode(coupleResponse.body);
                            user = user.copyWith(coupleId: couple['id']);

                            GetIt.instance.registerSingleton<User>(
                              User(
                                id: user.id,
                                coupleId: user.coupleId,
                                name: user.name,
                                email: user.email,
                                sex: user.sex,
                              ),
                            );
                            openMainPage();
                          } else {
                            print("failed to auth");
                            throw Exception('Failed to auth user.');
                          }
                        } catch (e) {
                          throw Exception();
                        }
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
