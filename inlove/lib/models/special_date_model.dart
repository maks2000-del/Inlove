class SpeicalDate {
  final int? id;
  final int coupleId;
  final String title;
  final String date;
  final int bgColorId;

  SpeicalDate({
    this.id,
    required this.coupleId,
    required this.title,
    required this.date,
    required this.bgColorId,
  });

  factory SpeicalDate.fromJson(Map<String, dynamic> json) => SpeicalDate(
        id: json['id'],
        coupleId: json['couple_id'],
        title: json['title'],
        date: json['action_date'].toString(),
        bgColorId: json['bg_color_id'],
      );

  Map<String, dynamic> toMap(int coupleId) {
    return {
      'couple_id': coupleId,
      'title': title,
      'date': date,
      'bg_color_id': bgColorId,
    };
  }
}
