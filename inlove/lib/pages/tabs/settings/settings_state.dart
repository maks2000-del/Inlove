import 'package:inlove/models/user_model.dart';

class SettingsState {
  final User usersParthner;
  final bool isPathnerChosen;
  final List<String> userNames;

  SettingsState({
    required this.usersParthner,
    required this.isPathnerChosen,
    required this.userNames,
  });

  SettingsState copyWith({
    User? usersParthner,
    bool? isPathnerChosen,
    List<String>? userNames,
  }) {
    return SettingsState(
      usersParthner: usersParthner ?? this.usersParthner,
      isPathnerChosen: isPathnerChosen ?? this.isPathnerChosen,
      userNames: userNames ?? this.userNames,
    );
  }
}
