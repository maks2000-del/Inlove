import 'package:path/path.dart';

class Memory {
  final int? id;
  final int coupleId;
  final String title;
  final String description;
  final String date;
  final String location;
  final String? photo;

  Memory({
    this.id,
    required this.coupleId,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'coupleId': coupleId,
      'title': title,
      'description': description,
      'date': date,
      'location': location,
      'photosId': photo != null
          ? basename(photo.toString())
              .substring(0, basename(photo.toString().toString()).length - 1)
          : "null",
    };
  }

  factory Memory.fromJson(Map<String, dynamic> json) => Memory(
        id: json['id'],
        coupleId: json['couple_id'],
        title: json['title'],
        description: json['description'],
        date: json['memory_date'].substring(0, 10),
        location: json['location'],
        photo: json['photos_id'] ?? "",
      );

  Map<String, dynamic> toMapForLocalDB() {
    return {
      'couple_id': coupleId,
      'title': title,
      'description': description,
      'date': date,
      'location': location,
      'photo_path': photo != null
          ? basename(photo.toString())
              .substring(0, basename(photo.toString().toString()).length - 1)
          : "null",
    };
  }

  factory Memory.fromSqliteEntitty(Map<String, dynamic> json) => Memory(
        id: json['id'],
        coupleId: json['couple_id'],
        title: json['title'],
        description: json['description'],
        date: json['date'].toString(),
        location: json['location'],
        photo: json['photo_path'] ?? "",
      );
}
