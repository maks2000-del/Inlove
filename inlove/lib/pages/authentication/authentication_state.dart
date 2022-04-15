import 'package:inlove/models/user_model.dart';

class AuthorizationState {
  final User user;
  final bool showAuthorizationComponent;

  AuthorizationState({
    required this.user,
    required this.showAuthorizationComponent,
  });

  AuthorizationState copyWith({
    final User? user,
    final bool? showAuthorizationComponent,
  }) {
    return AuthorizationState(
      user: user ?? this.user,
      showAuthorizationComponent:
          showAuthorizationComponent ?? this.showAuthorizationComponent,
    );
  }
}
