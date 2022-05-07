class SpeicalDate {
  final int id;
  final int coupleId;
  final String title;
  final String date;
  final int bgColorId;

  SpeicalDate({
    required this.id,
    required this.coupleId,
    required this.title,
    required this.date,
    required this.bgColorId,
  });

  factory SpeicalDate.fromJson(Map<String, dynamic> json) => SpeicalDate(
        id: json['id'],
        coupleId: json['couple_id'],
        title: json['title'],
        date: json['action_date'].toString().substring(0, 10),
        bgColorId: json['bg_color_id'],
      );
}
