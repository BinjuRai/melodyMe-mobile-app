// // import 'package:batch34_b/app/constant/api_endpoints.dart';
// // import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
// // import 'package:cached_network_image/cached_network_image.dart';
// // import 'package:flutter/material.dart';

// // class LessonCard extends StatelessWidget {
// //   final LessonEntity lesson;
// //   final VoidCallback? onTap;

// //   const LessonCard({super.key, required this.lesson, this.onTap});

// //   @override
// //   Widget build(BuildContext context) {
// //     // Define your theme colors here for convenience
// //     final Color darkBlue = const Color(0xFF222740);
// //     final Color lightBlue = const Color(0xFFC5CEF0);
// //     final Color lightPink = const Color(0xFFF0C5CE);

// //     return Card(
// //       elevation: 4,
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// //       color: lightBlue.withOpacity(0.15),
// //       shadowColor: darkBlue.withOpacity(0.3),
// //       child: InkWell(
// //         onTap: onTap,
// //         borderRadius: BorderRadius.circular(16),
// //         splashColor: lightPink.withOpacity(0.3),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // Lesson Image
// //             _buildLessonImage(),

// //             // Lesson Content
// //             Padding(
// //               padding: const EdgeInsets.all(16),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   // Title and Price Row
// //                   Row(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Expanded(
// //                         child: Text(
// //                           lesson.name,
// //                           style: TextStyle(
// //                             fontSize: 18,
// //                             fontWeight: FontWeight.bold,
// //                             color: darkBlue,
// //                           ),
// //                           maxLines: 2,
// //                           overflow: TextOverflow.ellipsis,
// //                         ),
// //                       ),
// //                       const SizedBox(width: 8),
// //                       _buildPriceChip(darkBlue, lightPink),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 8),

// //                   // Description
// //                   if (lesson.description != null &&
// //                       lesson.description!.isNotEmpty)
// //                     Text(
// //                       lesson.description!,
// //                       style: TextStyle(
// //                         color: darkBlue.withOpacity(0.7),
// //                         fontSize: 14,
// //                       ),
// //                       maxLines: 3,
// //                       overflow: TextOverflow.ellipsis,
// //                     ),
// //                   if (lesson.description != null &&
// //                       lesson.description!.isNotEmpty)
// //                     const SizedBox(height: 12),

// //                   // Lesson Info Row
// //                   Row(
// //                     children: [
// //                       if (lesson.authorName != null &&
// //                           lesson.authorName!.isNotEmpty) ...[
// //                         Icon(
// //                           Icons.person_outline,
// //                           size: 16,
// //                           color: darkBlue.withOpacity(0.6),
// //                         ),
// //                         const SizedBox(width: 4),
// //                         Expanded(
// //                           child: Text(
// //                             lesson.authorName!,
// //                             style: TextStyle(
// //                               color: darkBlue.withOpacity(0.6),
// //                               fontSize: 12,
// //                             ),
// //                             overflow: TextOverflow.ellipsis,
// //                           ),
// //                         ),
// //                       ],
// //                       if (lesson.duration != null &&
// //                           lesson.duration!.isNotEmpty) ...[
// //                         const SizedBox(width: 16),
// //                         Icon(
// //                           Icons.access_time,
// //                           size: 16,
// //                           color: darkBlue.withOpacity(0.6),
// //                         ),
// //                         const SizedBox(width: 4),
// //                         Text(
// //                           lesson.duration!,
// //                           style: TextStyle(
// //                             color: darkBlue.withOpacity(0.6),
// //                             fontSize: 12,
// //                           ),
// //                         ),
// //                       ],
// //                     ],
// //                   ),

// //                   // Course Info
// //                   if (lesson.course != null &&
// //                       lesson.course!.name.isNotEmpty) ...[
// //                     const SizedBox(height: 12),
// //                     Container(
// //                       padding: const EdgeInsets.symmetric(
// //                         horizontal: 10,
// //                         vertical: 6,
// //                       ),
// //                       decoration: BoxDecoration(
// //                         color: lightPink.withOpacity(0.3),
// //                         borderRadius: BorderRadius.circular(12),
// //                       ),
// //                       child: Text(
// //                         'Course: ${lesson.course!.name}',
// //                         style: TextStyle(
// //                           color: darkBlue,
// //                           fontWeight: FontWeight.w600,
// //                           fontSize: 13,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildLessonImage() {
// //     final String? imagePath = lesson.imagePath;

// //     final hasImage = imagePath != null && imagePath.isNotEmpty;

// //     String? fullImageUrl;

// //     if (hasImage) {
// //       final cleanImagePath =
// //           imagePath!.startsWith('/') ? imagePath.substring(1) : imagePath;

// //       fullImageUrl = ApiEndpoints.imageUrl + cleanImagePath;
// //     }

// //     return ClipRRect(
// //       borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
// //       child:
// //           hasImage
// //               ? CachedNetworkImage(
// //                 imageUrl: fullImageUrl!,
// //                 height: 180,
// //                 width: double.infinity,
// //                 fit: BoxFit.cover,
// //                 placeholder:
// //                     (context, url) => Container(
// //                       height: 180,
// //                       color: const Color(0xFFC5CEF0).withOpacity(0.3),
// //                       child: const Center(child: CircularProgressIndicator()),
// //                     ),
// //                 errorWidget:
// //                     (context, url, error) => Container(
// //                       height: 180,
// //                       color: const Color(0xFFC5CEF0).withOpacity(0.3),
// //                       child: const Icon(
// //                         Icons.broken_image,
// //                         size: 48,
// //                         color: Colors.grey,
// //                       ),
// //                     ),
// //               )
// //               : Container(
// //                 height: 180,
// //                 width: double.infinity,
// //                 color: const Color(0xFFC5CEF0).withOpacity(0.3),
// //                 child: const Icon(Icons.image, size: 48, color: Colors.grey),
// //               ),
// //     );
// //   }

// //   Widget _buildPriceChip(Color darkBlue, Color lightPink) {
// //     return Chip(
// //       backgroundColor: lightPink.withOpacity(0.3),
// //       label: Text(
// //         '\$${lesson.price.toStringAsFixed(2)}',
// //         style: TextStyle(color: darkBlue, fontWeight: FontWeight.bold),
// //       ),
// //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
// //     );
// //   }
// // }
import 'package:batch34_b/features/wishlist/presentation/view_model/wishlist_event.dart';
import 'package:batch34_b/features/wishlist/presentation/view_model/wishlist_state.dart';
import 'package:batch34_b/features/wishlist/presentation/view_model/wishlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:batch34_b/app/constant/api_endpoints.dart';
import 'package:batch34_b/core/common/card/heart_btn.dart';
import 'package:batch34_b/core/common/card/join_btn.dart';
import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LessonCard extends StatelessWidget {
  final LessonEntity lesson;
  final VoidCallback? onTap;
  final String userId;

  const LessonCard({
    super.key,
    required this.lesson,
    this.onTap,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF4B3F72);
    const lavender = Color(0xFFE6E0F8);
    const pinkPastel = Color(0xFFF6D1E0);
    const lightPurple = Color(0xFFDCC6FF);

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: lavender,
      shadowColor: darkBlue.withOpacity(0.3),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: pinkPastel.withOpacity(0.3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with soft rounded corners and slight shadow
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Stack(
                children: [
                  _buildLessonImage(),
                  // Musical notes decoration (small icons at top right)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Opacity(
                      opacity: 0.15,
                      child: Icon(Icons.music_note, size: 48, color: darkBlue),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + musical icon + price chip row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.music_note, size: 20, color: pinkPastel),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          lesson.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: darkBlue,
                            letterSpacing: 0.5,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildPriceChip(darkBlue, pinkPastel),
                    ],
                  ),
                  const SizedBox(height: 10),

                  if (lesson.description != null &&
                      lesson.description!.isNotEmpty)
                    Text(
                      lesson.description!,
                      style: TextStyle(
                        color: darkBlue.withOpacity(0.75),
                        fontSize: 15,
                        height: 1.3,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (lesson.description != null &&
                      lesson.description!.isNotEmpty)
                    const SizedBox(height: 14),

                  // Author & Duration row with softer icons
                  Row(
                    children: [
                      if (lesson.authorName != null &&
                          lesson.authorName!.isNotEmpty) ...[
                        Icon(
                          Icons.person_outline,
                          size: 18,
                          color: darkBlue.withOpacity(0.6),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            lesson.authorName!,
                            style: TextStyle(
                              color: darkBlue.withOpacity(0.6),
                              fontSize: 13,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                      if (lesson.duration != null &&
                          lesson.duration!.isNotEmpty) ...[
                        const SizedBox(width: 18),
                        Icon(
                          Icons.access_time,
                          size: 18,
                          color: darkBlue.withOpacity(0.6),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          lesson.duration!,
                          style: TextStyle(
                            color: darkBlue.withOpacity(0.6),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),

                  if (lesson.course != null &&
                      lesson.course!.name.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: pinkPastel.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        'Course: ${lesson.course!.name}',
                        style: TextStyle(
                          color: darkBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 18),

                  // Bottom row with wishlist heart & Join button aligned right
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocBuilder<WishlistBloc, WishlistState>(
                        builder: (context, state) {
                          bool isInWishlist = false;
                          if (state is WishlistLoaded) {
                            isInWishlist = state.lessons.any(
                              (l) => l.id == lesson.id,
                            );
                          }
                          return HeartButton(
                            isActive: isInWishlist,
                            onTap: () {
                              context.read<WishlistBloc>().add(
                                ToggleWishlistLesson(
                                  userId: userId,
                                  lesson: lesson,
                                  isInWishlist: isInWishlist,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(width: 20),
                      JoinButton(
                        onPressed: () {
                          // Navigate to payment page
                          Navigator.pushNamed(
                            context,
                            '/payment',
                            arguments: lesson,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonImage() {
    final String? imagePath = lesson.imagePath;
    final hasImage = imagePath != null && imagePath.isNotEmpty;

    String? fullImageUrl;
    if (hasImage) {
      final cleanImagePath =
          imagePath!.startsWith('/') ? imagePath.substring(1) : imagePath;
      fullImageUrl = ApiEndpoints.imageUrl + cleanImagePath;
    }

    return CachedNetworkImage(
      imageUrl: fullImageUrl ?? '',
      height: 180,
      width: double.infinity,
      fit: BoxFit.cover,
      placeholder:
          (context, url) => Container(
            height: 180,
            color: const Color(0xFFE6E0F8).withOpacity(0.5),
            child: const Center(child: CircularProgressIndicator()),
          ),
      errorWidget:
          (context, url, error) => Container(
            height: 180,
            color: const Color(0xFFE6E0F8).withOpacity(0.5),
            child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
          ),
    );
  }

  Widget _buildPriceChip(Color darkBlue, Color pinkPastel) {
    return Chip(
      backgroundColor: pinkPastel.withOpacity(0.4),
      label: Text(
        '\$${lesson.price.toStringAsFixed(2)}',
        style: TextStyle(color: darkBlue, fontWeight: FontWeight.bold),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      shadowColor: darkBlue.withOpacity(0.2),
    );
  }
}
