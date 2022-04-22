import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inlove/pages/authentication/authentication_state.dart';

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
                  inputController: passwordFieldController,
                ),
                NeumorphicToggle(
                  children: [
                    ToggleElement(
                      background: Center(child: Text('male')),
                    ),
                    ToggleElement(
                      background: Center(child: Text('female')),
                    ),
                  ],
                  thumb: Center(child: Text('a')),
                  selectedIndex: state.toggleSex,
                  onChanged: (selected) => {
                    authorizationCubit.switchToggleSex(selected),
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('I am single'),
                    NeumorphicSwitch(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    simpleButton(
                      size,
                      'REGISTER',
                      2.6,
                      () {
                        HapticFeedback.lightImpact();
                        Fluttertoast.showToast(msg: 'Register button pressed');
                        authorizationCubit.switchRegAuthComponent();
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
