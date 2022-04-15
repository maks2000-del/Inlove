import 'package:inlove/models/user_model.dart';

class HomeState {
  final String title;
  final int pageIndex;

  HomeState({
    required this.title,
    required this.pageIndex,
  });

  HomeState copyWith({
    String? title,
    int? pageIndex,
  }) {
    return HomeState(
      title: title ?? this.title,
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }
}
