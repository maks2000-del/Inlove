import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get_it/get_it.dart';
import 'package:inlove/pages/authentication/authentication_cubit.dart';
import 'package:inlove/pages/authentication/authentication_state.dart';
import 'package:inlove/pages/authentication/authorization_component.dart';
import 'package:inlove/pages/authentication/registration_component.dart';

import 'package:inlove/pages/home/home_page.dart';

import '../../repository/couple_repository.dart';
import '../../repository/user_repository.dart';

class AuthorizationPage extends StatefulWidget {
  static const routeName = '/authorizationPage';
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage>
    with SingleTickerProviderStateMixin {
  final _userPerository = GetIt.instance.get<UserPerository>();
  final _coupleRepository = GetIt.instance.get<CoupleRepository>();

  final AuthorizationCubit _authorizationCubit = AuthorizationCubit();

  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _transform;

  final _nameController = TextEditingController();
  final _mailController = TextEditingController();
  final _passswordController = TextEditingController();
  final _repeatPassswordController = TextEditingController();

  @override
  void initState() {
    _authorizationCubit.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )..addListener(() {
        setState(() {});
      });

    _transform = Tween<double>(begin: 2, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    void _openMainPage() {
      Navigator.pushNamed(context, HomePage.routeName);
    }

    Future<bool> _onWillPop() async {
      return false;
    }

    return BlocBuilder<AuthorizationCubit, AuthorizationState>(
      bloc: _authorizationCubit,
      builder: (context, state) {
        return WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            body: ScrollConfiguration(
              behavior: const ScrollBehavior(),
              child: SingleChildScrollView(
                child: state.showAuthorizationComponent
                    ? authorizationComponent(
                        size: _size,
                        opacity: _opacity,
                        transform: _transform,
                        authorizationCubit: _authorizationCubit,
                        openMainPage: _openMainPage,
                        nameFieldController: _nameController,
                        mailFieldController: _mailController,
                        passwordFieldController: _passswordController,
                        userPerository: _userPerository,
                        coupleRepository: _coupleRepository,
                      )
                    : registrationComponent(
                        size: _size,
                        opacity: _opacity,
                        transform: _transform,
                        authorizationCubit: _authorizationCubit,
                        state: state,
                        nameFieldController: _nameController,
                        mailFieldController: _mailController,
                        passwordFieldController: _passswordController,
                        repeatPasswordFieldController:
                            _repeatPassswordController,
                        userPerository: _userPerository,
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
