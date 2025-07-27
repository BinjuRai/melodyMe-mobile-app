import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/lesson/data/model/lesson_api_model.dart';
import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
import 'package:batch34_b/features/wishlist/data/data_source/wishlist_datasourse.dart';
import 'package:batch34_b/features/wishlist/domain/repository/wishlist_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource remoteDataSource;

  WishlistRepositoryImpl({required this.remoteDataSource});

  LessonModel _entityToModel(LessonEntity entity) {
    return LessonModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      authorName: entity.authorName,
      duration: entity.duration,
      price: entity.price,
      courseInfo:
          entity.courseId != null
              ? CourseInfo(
                id: entity.courseId!,
                name: entity.courseName ?? 'Unknown Course',
              )
              : null,
      sellerInfo: SellerInfo(
        id: entity.sellerId ?? '',
        firstName: entity.sellerName ?? 'Unknown Seller',
        email: entity.sellerEmail ?? '',
      ),
      imagepath: entity.imagePath,
      filepath: entity.filePath,
      createdAt: entity.createdAt.toIso8601String(),
      updatedAt: entity.updatedAt.toIso8601String(),
    );
  }

  @override
  Future<Either<Failure, List<LessonEntity>>> getWishlistLessons(
    String userId,
  ) async {
    try {
      final models = await remoteDataSource.getWishlistLessons(userId);
      final lessons = models.map((m) => m.toEntity()).toList();
      return Right(lessons);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          message: e.message ?? 'Server error while fetching wishlist',
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addLessonToWishlist(
    String userId,
    LessonEntity lesson,
  ) async {
    try {
      final lessonModel = _entityToModel(lesson);
      await remoteDataSource.addLessonToWishlist(userId, lessonModel);
      return const Right(null);
    } on DioException catch (e) {
      return Left(
        ServerFailure(message: e.message ?? 'Failed to add lesson to wishlist'),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeLessonFromWishlist(
    String userId,
    String lessonId,
  ) async {
    try {
      await remoteDataSource.removeLessonFromWishlist(userId, lessonId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          message: e.message ?? 'Failed to remove lesson from wishlist',
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, LessonEntity>> getLessonById(String lessonId) async {
    try {
      final model = await remoteDataSource.getLessonById(lessonId);
      return Right(model.toEntity());
    } on DioException catch (e) {
      return Left(
        ServerFailure(message: e.message ?? 'Failed to get lesson by ID'),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
