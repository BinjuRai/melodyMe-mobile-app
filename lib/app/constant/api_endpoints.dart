class ApiEndpoints {
  ApiEndpoints._();

  // Timeouts

  // static const connectionTimeout = Duration(seconds: 1000);
  // static const receiveTimeout = Duration(seconds: 1000);
  static const Duration connectionTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);

  // For iOS Simulator
  static const String serverAddress = "http://localhost:5050";
  // static const String serverAddress = "http://10.0.2.2:5050";

  // For iPhone (uncomment if needed)
  // static const String baseUrl = "$serverAddress/api/v1/";
  // static const String imageUrl = "$baseUrl/uploads/";
  static const String baseUrl = "$serverAddress/api/";
  static const String imageUrl = "$serverAddress/uploads/";

  // static const String imageUrl = "$baseUrl/uploads/";
  // static const String imageUrl = "http://10.0.2.2:5050/api/";

  // Auth

  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String uploadImage = "auth/uploadImage";

  // static const String createCourse = "course";
  static const String getAllCourse = "admin/courses";

  // static const String getAllLessons = "admin/lesson";
  static const String getAllLessons = "admin/lesson";
  static const String getLessonById = "admin/lesson";

  // static const String createLesson = "admin/lessons";
  // static const String updateLesson = "admin/lessons/";
  // static const String deleteLesson = "admin/lessons/";

  // static const String login = "auth/login";
  // static const String register = "auth/register";
  // static const String getAllStudent = "auth/getAllStudents";
  // static const String getStudentsByBatch = "auth/getStudentsByBatch/";
  // static const String getStudentsByCourse = "auth/getStudentsByCourse/";
  // static const String updateUser = "auth/updateUser/";
  // static const String deleteStudent = "auth/deleteStudent/";

  // // Batch
  // static const String createBatch = "batch/createBatch";
  // static const String getAllBatch = "batch/getAllBatches";
  // static const String deleteBatch = "batch/";

  // // // Course
  // static const String createCourse = "course/createCourse";
  // static const String getAllCourse = "course/getAllCourse";
  // Course endpoints
}
