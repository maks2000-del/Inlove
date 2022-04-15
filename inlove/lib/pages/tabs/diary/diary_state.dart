import 'package:inlove/models/user_model.dart';

class DiaryState {
  final int memoryId;

  DiaryState({
    required this.memoryId,
  });

  DiaryState copyWith({
    int? memoryId,
  }) {
    return DiaryState(
      memoryId: memoryId ?? this.memoryId,
    );
  }
}
