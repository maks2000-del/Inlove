import 'package:inlove/models/user_model.dart';

class SettingsState {
  final User usersParthner;
  final bool isPathnerChosen;

  SettingsState({required this.usersParthner, required this.isPathnerChosen});

  SettingsState copyWith({
    User? usersParthner,
    bool? isPathnerChosen,
  }) {
    return SettingsState(
      usersParthner: usersParthner ?? this.usersParthner,
      isPathnerChosen: isPathnerChosen ?? this.isPathnerChosen,
    );
  }
}
