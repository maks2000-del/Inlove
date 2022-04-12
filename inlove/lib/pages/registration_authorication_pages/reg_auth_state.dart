import 'package:inlove/models/user_model.dart';

class RegAuthState {
  final User user;

  RegAuthState({
    required this.user,
  });

  RegAuthState copyWith({
    final User? user,
  }) {
    return RegAuthState(
      user: user ?? this.user,
    );
  }
}
