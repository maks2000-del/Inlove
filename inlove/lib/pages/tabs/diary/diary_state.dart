import 'dart:io';

import 'package:inlove/models/memory_model.dart';

class DiaryState {
  final List<Memory> coupleMemorys;
  final File? pickedPhoto;

  DiaryState({
    required this.coupleMemorys,
    this.pickedPhoto,
  });

  DiaryState copyWith({
    List<Memory>? coupleMemorys,
    File? pickedPhoto,
  }) {
    return DiaryState(
      coupleMemorys: coupleMemorys ?? this.coupleMemorys,
      pickedPhoto: pickedPhoto ?? this.pickedPhoto,
    );
  }
}
