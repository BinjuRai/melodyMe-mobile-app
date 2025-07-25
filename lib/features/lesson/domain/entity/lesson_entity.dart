

// import 'package:batch34_b/features/auth/domain/entity/user_entity.dart';
// import 'package:batch34_b/features/course/domain/entity/course_entity.dart' as course;




// class LessonEntity {
//   final String id;
//   final String name;
//   final double price;
//   final String? description;
//   final String? authorName;
//   final String? duration;
//   final String? imagePath;
//   final String? filePath;
//   final CourseEntity? course;
//   final SellerEntity? seller;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   LessonEntity({
//     required this.id,
//     required this.name,
//     required this.price,
//     this.description,
//     this.authorName,
//     this.duration,
//     this.imagePath,
//     this.filePath,
//     this.course,
//     this.seller,
//     required this.createdAt,
//     required this.updatedAt,
//   });
// }

// class CourseEntity {
//   final String id;
//   final String name;
//  final double totalPrice;
//   final String? filepath;

//   CourseEntity({
//     required this.id,
//     required this.name,
//     required this.totalPrice,
//     this.filepath,
//   });

//   // Convert from the course feature CourseEntity to this one
//   factory CourseEntity.fromCourseCourseEntity(course.CourseEntity c) {
//     return CourseEntity(id: c.id, name: c.name, totalPrice: 0.0, filepath: null);
//   }

//   // Convert to the course feature CourseEntity
//   course.CourseEntity toCourseCourseEntity() {
//     return course.CourseEntity(id: id, name: name, totalPrice: totalPrice, filepath: filepath);
//   }
// }

// class SellerEntity {
//   final String id;
//   final String name;
//   final String email;

//   SellerEntity({
//     required this.id,
//     required this.name,
//     required this.email,
//   });

//   /// Convert from UserEntity to SellerEntity
//   factory SellerEntity.fromUser(UserEntity user) {
//     return SellerEntity(
//       id: user.userId ?? '', // fallback to empty string if null
//       name: user.username,   // FIXED: Use username instead of name
//       email: user.email,
//     );
//   }

//   /// Convert back to UserEntity
//   UserEntity toUser() {
//     return UserEntity(
//       userId: id,
//       username: name,       // Reuse name as username
//       email: email,
//       phoneno: '',          // Set defaults or fetch dynamically
//       password: '',
//     );
//   }
// }

// class LessonPagination {
//   final int total;
//   final int page;
//   final int limit;
//   final int totalPages;
//   final bool hasNext;
//   final bool hasPrev;

//   LessonPagination({
//     required this.total,
//     required this.page,
//     required this.limit,
//     required this.totalPages,
//     required this.hasNext,
//     required this.hasPrev,
//   });
// }

// class LessonResponse {
//   final List<LessonEntity> lessons;
//   final LessonPagination pagination;

//   LessonResponse({
//     required this.lessons,
//     required this.pagination,
//   });
// }

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
  final String sellerId;
  final String sellerName;
  final String sellerEmail;
  final String imagePath;
  final String filePath;
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
    required this.sellerId,
    required this.sellerName,
    required this.sellerEmail,
    required this.imagePath,
    required this.filePath,
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
      sellerId: '',
      sellerName: '',
      sellerEmail: '',
      imagePath: '',
      filePath: '',
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
