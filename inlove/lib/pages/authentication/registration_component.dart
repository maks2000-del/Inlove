import 'package:flutter/gestures.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inlove/pages/authentication/authentication_state.dart';
import 'package:inlove/repository/user_repository.dart';

import '../../components/button.dart';
import '../../components/input_textfield.dart';
import 'authentication_cubit.dart';

Widget registrationComponent({
  required Size size,
  required Animation<double> opacity,
  required Animation<double> transform,
  required AuthorizationCubit authorizationCubit,
  required AuthorizationState state,
  required TextEditingController nameFieldController,
  required TextEditingController mailFieldController,
  required TextEditingController passwordFieldController,
  required TextEditingController repeatPasswordFieldController,
  required UserPerository userPerository,
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
            height: size.width * 1.4,
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
                  'Registration',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(.7),
                  ),
                ),
                const SizedBox(),
                inputTextfield(
                  size: size,
                  icon: Icons.account_circle_outlined,
                  hintText: 'User name...',
                  isPassword: false,
                  isEmail: false,
                  inputController: nameFieldController,
                ),
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
                inputTextfield(
                  size: size,
                  icon: Icons.lock_outline,
                  hintText: 'Repeat password...',
                  isPassword: true,
                  isEmail: false,
                  inputController: repeatPasswordFieldController,
                ),
                NeumorphicToggle(
                  height: 50.0,
                  width: 200.0,
                  children: [
                    ToggleElement(
                      background: const Center(child: Text('male')),
                    ),
                    ToggleElement(
                      background: const Center(child: Text('female')),
                    ),
                  ],
                  thumb: Center(
                    child: Text(
                      state.toggleSex == 0 ? 'male' : 'female',
                    ),
                  ),
                  selectedIndex: state.toggleSex,
                  onChanged: (selected) => {
                    authorizationCubit.switchToggleSex(selected),
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'I already have an account',
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
                    simpleButton(
                      size,
                      'REGISTER',
                      2.6,
                      () async {
                        authorizationCubit.registerUser(
                          nameFieldController.text,
                          mailFieldController.text,
                          passwordFieldController.text,
                          repeatPasswordFieldController.text,
                          userPerository,
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
