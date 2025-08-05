// import 'package:equatable/equatable.dart';

// abstract class Failure extends Equatable {
//   final String message;

//   const Failure(String message, {required this.message});

//   @override
//   List<Object?> get props => [message];
// }

// class LocalDatabaseFailure extends Failure {
//   const LocalDatabaseFailure({required super.message});
// }

// class RemoteDatabaseFailure extends Failure {
//   final int? statusCode;
//   const RemoteDatabaseFailure({this.statusCode, required super.message});
// }

// class SharedPreferencesFailure extends Failure {
//   const SharedPreferencesFailure({required super.message});
// }

// class ServerFailure extends Failure {
//   const ServerFailure(String s, {required super.message});
// }


// class ServerException implements Exception {
//   final String message;
//   ServerException(this.message);
// }
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class LocalDatabaseFailure extends Failure {
  const LocalDatabaseFailure({required super.message});
}

class RemoteDatabaseFailure extends Failure {
  final int? statusCode;
  const RemoteDatabaseFailure({this.statusCode, required super.message});
}

class SharedPreferencesFailure extends Failure {
  const SharedPreferencesFailure({required super.message});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}


class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}