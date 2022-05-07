import 'package:inlove/models/memory_model.dart';
import 'package:inlove/models/user_model.dart';

class DiaryState {
  final List<Memory> coupleMemorys;

  DiaryState({
    required this.coupleMemorys,
  });

  DiaryState copyWith({
    List<Memory>? coupleMemorys,
  }) {
    return DiaryState(
      coupleMemorys: coupleMemorys ?? this.coupleMemorys,
    );
  }
}
