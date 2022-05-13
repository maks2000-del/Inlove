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

  Map<String, dynamic> toMap() {
    return {
      'coupleId': coupleId,
      'title': title,
      'actionDate': date,
      'bgColorId': bgColorId,
    };
  }

  factory SpeicalDate.fromJson(Map<String, dynamic> json) => SpeicalDate(
        id: json['id'],
        coupleId: json['couple_id'],
        title: json['title'],
        date: json['action_date'].toString().substring(0, 10),
        bgColorId: json['bg_color_id'],
      );

  Map<String, dynamic> toMapForLocalDB() {
    return {
      'couple_id': coupleId,
      'title': title,
      'date': date,
      'bg_color_id': bgColorId,
    };
  }

  factory SpeicalDate.fromSqliteEntitty(Map<String, dynamic> sqlEntity) =>
      SpeicalDate(
        id: sqlEntity['id'],
        coupleId: sqlEntity['couple_id'],
        title: sqlEntity['title'],
        date: sqlEntity['date'].toString().substring(0, 10),
        bgColorId: sqlEntity['bg_color_id'],
      );
}
