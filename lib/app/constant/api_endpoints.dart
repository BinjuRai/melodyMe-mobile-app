class ApiEndpoints {
  ApiEndpoints._();

  // Timeouts

  // static const connectionTimeout = Duration(seconds: 1000);
  // static const receiveTimeout = Duration(seconds: 1000);
  static const Duration connectionTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);

  // For iOS Simulator
  static const String serverAddress = "http://localhost:5050";
  // static const String serverAddress = "http://192.168.1.80:5050";

  // For iPhone (uncomment if needed)
  // static const String baseUrl = "$serverAddress/api/v1/";
  // static const String imageUrl = "$baseUrl/uploads/";
  static const String baseUrl = "$serverAddress/api/";
  static const String imageUrl = "$serverAddress/";

  // static const String imageUrl = "$baseUrl/uploads/";
  // static const String imageUrl = "http://10.0.2.2:5050/api/";

  // Auth

  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String uploadImage = "auth/uploadImage";

  static const String getProfile = 'auth/profile';
  static const String updateProfile = 'auth/profile';
  static const String changePassword = 'auth/change-password';

  static const String getAllCourse = "admin/courses";

  static const String getCourseById =
      "admin/courses/:id"; // GET /api/admin/courses/:id
  static const String createCourse = "admin/courses"; // POST /api/admin/courses
  static const String updateCourse =
      "admin/courses/:id"; // PUT /api/admin/courses/:id
  static const String deleteCourse =
      "admin/courses/:id"; // DELETE /api/admin/courses/:id
  static const String getCourseLessons =
      "admin/courses/:id/lessons"; // GET /api/admin/courses/:id/lessons

  // static const String getAllLessons = "admin/lesson";
  static const String getAllLessons = "admin/lesson";
  static const String getLessonById = "admin/lesson";

  // Wishlist
  static const String getWishlistLessons = "normal/wishlist";
  static const String getWishlistLessonById = "normal/wishlist";
  static const String addLessonToWishlist = "normal/wishlist";
  static const String removeLessonFromWishlist = "normal/wishlist/remove";

  static const String createPayment = "api/payment";
  static const String getAllPayments = "api/payment";
  static const String getPaymentById = "api/payment";
}
