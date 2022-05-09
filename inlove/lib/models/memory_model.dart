class Memory {
  final int id;
  final int coupleId;
  final String title;
  final String description;
  final String date;
  final String location;
  final String photo;

  Memory({
    required this.id,
    required this.coupleId,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.photo,
  });

  factory Memory.fromJson(Map<String, dynamic> json) => Memory(
        id: json['id'],
        coupleId: json['couple_id'],
        title: json['title'],
        description: json['description'],
        date: json['memory_date'].toString().substring(0, 10),
        location: json['location'],
        photo: json['photos_id'],
      );
}
