import 'package:inlove/models/entities/short_user.dart';

class SettingsState {
  final bool isPathnerChosen;
  final bool isWaitingForRequest;
  final String parthnerName;
  final String coupleStatus;
  final List<ShortUser> shortUsers;
  final int? parthnerId;

  SettingsState({
    required this.isPathnerChosen,
    required this.isWaitingForRequest,
    required this.parthnerName,
    required this.coupleStatus,
    required this.shortUsers,
    this.parthnerId,
  });

  SettingsState copyWith({
    bool? isPathnerChosen,
    bool? isWaitingForRequest,
    String? parthnerName,
    String? coupleStatus,
    List<ShortUser>? shortUsers,
    int? parthnerId,
  }) {
    return SettingsState(
      isPathnerChosen: isPathnerChosen ?? this.isPathnerChosen,
      isWaitingForRequest: isWaitingForRequest ?? this.isWaitingForRequest,
      parthnerName: parthnerName ?? this.parthnerName,
      coupleStatus: coupleStatus ?? this.coupleStatus,
      shortUsers: shortUsers ?? this.shortUsers,
      parthnerId: parthnerId ?? this.parthnerId,
    );
  }
}
