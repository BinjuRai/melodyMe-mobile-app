import 'package:batch34_b/features/course/domain/entity/course_entity.dart';
import 'package:equatable/equatable.dart';

class LessonEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String authorName;
  final String duration;
  final double price;
  final String? courseId;
  final String? courseName;
  final String? sellerId;
  final String? sellerName;
  final String? sellerEmail;
  final String? imagePath;
  final String? filePath;
  final DateTime createdAt;
  final DateTime updatedAt;
  final CourseEntity? course;

  const LessonEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.authorName,
    required this.duration,
    required this.price,
    this.courseId,
    this.courseName,
    this.sellerId,
    this.sellerName,
    this.sellerEmail,
    this.imagePath,
    this.filePath,
    required this.createdAt,
    required this.updatedAt,
    this.course,
  });

  factory LessonEntity.empty() {
    return LessonEntity(
      id: '',
      name: '',
      description: '',
      authorName: '',
      duration: '',
      price: 0.0,
      courseId: null,
      courseName: null,
      sellerId: null,
      sellerName: null,
      sellerEmail: null,
      imagePath: null,
      filePath: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    authorName,
    duration,
    price,
    courseId,
    courseName,
    sellerId,
    sellerName,
    sellerEmail,
    imagePath,
    filePath,
    createdAt,
    updatedAt,
  ];
}

class LessonPagination extends Equatable {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final bool hasNext;
  final bool hasPrev;

  const LessonPagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.hasNext,
    required this.hasPrev,
  });

  factory LessonPagination.empty() {
    return const LessonPagination(
      currentPage: 1,
      totalPages: 1,
      totalItems: 0,
      itemsPerPage: 10,
      hasNext: false,
      hasPrev: false,
    );
  }

  @override
  List<Object> get props => [
    currentPage,
    totalPages,
    totalItems,
    itemsPerPage,
    hasNext,
    hasPrev,
  ];
}
