import 'package:jwt_decode/jwt_decode.dart';

class JwtDecoderHelper {
  /// Extracts userId (or sub) from JWT token string.
  static String? getUserIdFromToken(String token) {
    try {
      final payload = Jwt.parseJwt(token);
      return payload['userId'] ?? payload['sub'] ?? payload['_id'];
    } catch (e) {
      // Handle or log error if needed
      return null;
    }
  }
}
