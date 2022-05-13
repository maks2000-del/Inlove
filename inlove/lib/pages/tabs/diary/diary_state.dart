import 'package:image_picker/image_picker.dart';
import 'package:inlove/models/memory_model.dart';

class DiaryState {
  final List<Memory> coupleMemorys;
  final ImagePicker picker = ImagePicker();

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
