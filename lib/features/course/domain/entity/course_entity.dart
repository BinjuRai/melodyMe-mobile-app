class CourseEntity {
  final String id;
  final String name;
  final double totalPrice;
  final String? filepath;

  CourseEntity({
    required this.id,
    required this.name,
    required this.totalPrice,
    this.filepath,
  });

  factory CourseEntity.fromJson(Map<String, dynamic> json) {
    return CourseEntity(
      id: json['_id'] ?? '', 
      name: json['name'] ?? '',
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      filepath: json['filepath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'totalPrice': totalPrice,
      'filepath': filepath,
    };
  }
}