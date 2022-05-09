class HomeState {
  final String title;
  final int tabIndex;

  HomeState({
    required this.title,
    required this.tabIndex,
  });

  HomeState copyWith({
    String? title,
    int? tabIndex,
  }) {
    return HomeState(
      title: title ?? this.title,
      tabIndex: tabIndex ?? this.tabIndex,
    );
  }
}
