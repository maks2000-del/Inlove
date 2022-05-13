class AuthorizationState {
  final bool showAuthorizationComponent;
  final int toggleSex;

  AuthorizationState({
    required this.showAuthorizationComponent,
    required this.toggleSex,
  });

  AuthorizationState copyWith({
    final bool? showAuthorizationComponent,
    final int? toggleSex,
  }) {
    return AuthorizationState(
      showAuthorizationComponent:
          showAuthorizationComponent ?? this.showAuthorizationComponent,
      toggleSex: toggleSex ?? this.toggleSex,
    );
  }
}
