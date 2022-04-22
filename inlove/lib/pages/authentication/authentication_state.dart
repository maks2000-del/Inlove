import 'package:inlove/models/user_model.dart';

class AuthorizationState {
  final User user;
  final bool showAuthorizationComponent;
  final int toggleSex;

  AuthorizationState({
    required this.user,
    required this.showAuthorizationComponent,
    required this.toggleSex,
  });

  AuthorizationState copyWith({
    final User? user,
    final bool? showAuthorizationComponent,
    final int? toggleSex,
  }) {
    return AuthorizationState(
      user: user ?? this.user,
      showAuthorizationComponent:
          showAuthorizationComponent ?? this.showAuthorizationComponent,
      toggleSex: toggleSex ?? this.toggleSex,
    );
  }
}
