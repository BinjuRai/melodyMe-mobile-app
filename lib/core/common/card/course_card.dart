import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:batch34_b/app/constant/api_endpoints.dart';
import 'package:batch34_b/features/course/domain/entity/course_entity.dart';

class CourseCard extends StatelessWidget {
  final CourseEntity course;
  final VoidCallback? onTap;

  const CourseCard({Key? key, required this.course, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color lavender = Color(0xFFEDE7F6);
    const Color pinkAccent = Color(0xFFF8BBD0);
    const Color deepPurple = Color.fromARGB(255, 13, 14, 73);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: lavender,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: pinkAccent.withOpacity(0.3),
        child: Container(
          height: 150,
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _buildCourseImage(),
              const SizedBox(width: 12),
              Expanded(
                child: Stack(
                  children: [
                    // Text info
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 100,
                      ), // reserve space for button
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.music_note,
                                size: 18,
                                color: deepPurple,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "Course",
                                style: TextStyle(
                                  color: deepPurple,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            course.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: deepPurple,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${course.totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: deepPurple.withOpacity(0.7),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Positioned button bottom right
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SizedBox(
                        height: 36,
                        child: ElevatedButton.icon(
                          onPressed: onTap,
                          icon: const Icon(Icons.play_arrow, size: 16),
                          label: const Text(
                            "View 🎧",
                            style: TextStyle(fontSize: 14),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: deepPurple,
                            foregroundColor: pinkAccent,
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseImage() {
    final String? filepath = course.filepath;
    final hasImage = filepath != null && filepath.isNotEmpty;

    String? fullImageUrl;
    if (hasImage) {
      final cleanPath =
          filepath!.startsWith('/') ? filepath.substring(1) : filepath;
      fullImageUrl = ApiEndpoints.imageUrl + cleanPath;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child:
          hasImage
              ? CachedNetworkImage(
                imageUrl: fullImageUrl!,
                width: 90,
                height: 110,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => Container(
                      width: 90,
                      height: 110,
                      color: Colors.pink[50],
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                errorWidget:
                    (context, url, error) => Container(
                      width: 90,
                      height: 110,
                      color: Colors.purple[50],
                      child: const Icon(Icons.broken_image, size: 32),
                    ),
              )
              : Container(
                width: 90,
                height: 110,
                color: Colors.purple[50],
                child: const Icon(Icons.image, size: 32, color: Colors.grey),
              ),
    );
  }
}
